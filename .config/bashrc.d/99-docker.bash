#
# Generate a sensible DISPLAY variable depending on platform.
#
function _display {
	if [[ "$OSTYPE" == "darwin"* ]]; then
		echo "$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}'):0"
	else
		echo "$DISPLAY:0"
	fi
}

#
# Setup xauth for running X11 apps inside the container.
#
function _xauth {
	container_name="$1"

	if [[ -z "$container_name" ]]; then
		echo "container_name cannot be blank."
		exit 1
	fi

	if [[ -z $(command -v xauth) ]]; then
		echo ""
	else
		display=$(echo $DISPLAY | cut -d: -f2)
		xauth_file="/tmp/.${container_name}.${display}.xauth"
		if [[ ! -f $xauth_file ]]; then
			touch $xauth_file
			xauth nlist :$display | sed -e 's/^..../ffff/' | xauth -f $xauth_file nmerge -
		fi

		echo $xauth_file
	fi
}

#
# Cobble together some default arguments.  Highly opinionated.
#
function _default_args {
	container_name="$1"

	if [[ -z "$container_name" ]]; then
		echo "container_name cannot be blank."
		exit 1
	fi

	args=(--rm -it)

	args+=(--name $container_name)

	echo "${args[@]}"
}

#
# Piece together the necessary arguments for running X11 apps inside the
# container.
#
function _x11_args {
	container_name="$1"

	if [[ -z "$container_name" ]]; then
		echo "container_name cannot be blank."
		exit 1
	fi

	if [[ -d /tmp/.X11-unix ]]; then
		args+=(-v /tmp/.X11-unix:/tmp/.X11-unix)
	fi

	XAUTH=$(_xauth "$container_name")
	if [[ -n "$XAUTH" ]]; then
		args+=(-v $XAUTH:$XAUTH)
		args+=(-e XAUTHORITY=$XAUTH)
	fi

	DISPLAY=$(_display)
	if [[ -n "$DISPLAY" ]]; then
		args+=(-e DISPLAY)
	fi

	args+=(--net=host)

	echo "${args[@]}"
}

#
# Common logic for running ansible commands.
#
function _ansible_base {
	ansible_command=$1
	shift

	docker run \
		$(_default_args ansible) \
		-v $(pwd):/usr/src/app \
		-v $SSH_AUTH_SOCK:/ssh-agent \
		-v $(pwd)/.aws/credentials:/root/.aws/credentials \
		-e SSH_AUTH_SOCK=/ssh-agent \
		--tmpfs /tmp \
		jdubz/ansible:2.2.1.0-r1 \
		$ansible_command \
		"$@"
}

# Disabling these until I find a cleaner way to handle things like AWS
# credentials and nested directories
# function ansible {
# 	_ansible_base ansible "$@"
# }

# function ansible-playbook {
# 	_ansible_base ansible-playbook "$@"
# }

# function ansible-vault {
# 	_ansible_base ansible-vault "$@"
# }

function _bats {
	test_path=$1
	shift
	if [[ -z "$test_path" ]]; then
		echo "You must supply the path to your tests." >&2
		exit 1
	fi
	code_path=$(dirname $(realpath $test_path))

	docker run \
		$(_default_args bats) \
		-v $code_path:/my-code \
		dduportal/bats:0.4.0 \
		/my-code/test \
		"$@"
}
function eclipse {
	if [[ ! -f /tmp/.eclipse.xauth ]]; then
		touch /tmp/.eclipse.xauth
		xauth nlist :0 | sed -e 's/^..../ffff/' | xauth -f /tmp/.eclipse.xauth nmerge -
	fi
	docker run \
		$(_default_args eclipse) \
		$(_x11_args eclipse) \
		-v $(pwd):/home/eclipse/workspace \
		jdubz/eclipse:4.5.1 \
		"$@"
}

function elixirdev {
	elixir_version="$1"
	elixir_command="$2"
	shift 2
	docker run \
		$(_default_args elixir_dev) \
		-v $(pwd):/usr/src/app \
		jdubz/elixir-dev:$elixir_version \
		"$elixir_command" \
		"$@"
}

# function go {
# 	if [[ -z "$GOPATH" ]]; then
# 		echo "GOPATH must be set"
# 		return 1
# 	fi

# 	# Make sure the current directory is somewhere inside GOPATH
# 	if [[ "$(pwd)" == "$GOPATH"* ]]; then
# 		# make the path relative so it can be resolved in the container
# 		workdir="${PWD/#$GOPATH/}"

# 		if [[ -z "$workdir" ]]; then
# 			workdir="."
# 		fi

# 		# fire it off
# 		docker run \
# 			$(_default_args go) \
# 			-v $GOPATH:/go \
# 			--name go \
# 			jdubz/golang:1.5.1 \
# 			$workdir \
# 			"$@"
# 	else
# 		echo "Current directory not in GOPATH"
# 		return 1
# 	fi
# }

function gradle {
	if [[ ! -d $(pwd)/.gradle_caches ]]; then
		mkdir $(pwd)/.gradle_caches
	fi
	docker run \
		$(_default_args gradle) \
		$(_x11_args gradle) \
		-v $(pwd):/usr/src/app \
		-v $(pwd)/.gradle_caches:/root/.gradle/caches \
		jdubz/gradle:2.0 \
		"$@"
}

# Doesn't really work well with nested inventories
# function terraform {
# 	docker run \
# 		$(_default_args terraform) \
# 		-v $(pwd):/usr/src/app \
# 		jdubz/terraform:0.8.4 \
# 		"$@"
# }

function virt-manager {
	docker run \
		$(_default_args virt-manager) \
		$(_x11_args virt-manager) \
		-v virt-manager-volume:/root/.config \
		jdubz/virt-manager \
		"$@"
}

# function obs {
# 	XSOCK=/tmp/.X11-unix
# 	XAUTH=/tmp/.obs.xauth
# 	if [[ ! -f "${XAUTH}" ]]; then
# 		touch "${XAUTH}"
# 		xauth nlist :0 | sed -e 's/^..../ffff/' | xauth -f "${XAUTH}" nmerge-
# 	fi
# 		# -e XAUTHORITY=/tmp/.obs.xauth \
# 	docker run \
# 		--rm \
# 		-it \
# 		-v ${XSOCK}:${XSOCK}:rw \
# 		-v ${XAUTH}:${XAUTH}:rw \
# 		-e DISPLAY \
# 		-e QT_X11_NO_MITSHM=1 \
# 		-e XAUTHORITY=${XAUTH} \
# 		--device /dev/dri \
# 		--name obs \
# 		jdubz/obs:0.14.2 "$@"

# }

# vim: set et ts=4 sw=4 sts=4 ft=sh:
