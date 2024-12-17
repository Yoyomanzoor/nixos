{ lib, ... }:

{
  programs = {
    wofi = {
      enable = true;
      settings = {
        show = "drun";
        always_parse_args = true;
        show_all = false;
        term = "kitty";
        hide_scroll = true;
        print_command = true;
        insensitive = true;
        columns = 2;
      };
      style = lib.mkForce ''
/* Window */
window {
  margin: 0px;
  padding: 10px;
  border: 0.16em solid;
  border-radius: 0.1em;
  animation: slideIn 0.5s ease-in-out both;
}

/* Slide In */
@keyframes slideIn {
  0% {
     opacity: 0;
  }

  100% {
     opacity: 1;
  }
}

/* Inner Box */
#inner-box {
  margin: 5px;
  padding: 10px;
  border: none;
  animation: fadeIn 0.5s ease-in-out both;
}

/* Fade In */
@keyframes fadeIn {
  0% {
     opacity: 0;
  }

  100% {
     opacity: 1;
  }
}

/* Outer Box */
#outer-box {
  margin: 5px;
  padding: 10px;
  border: none;
}

/* Scroll */
#scroll {
  margin: 0px;
  padding: 10px;
  border: none;
}

/* Input */
#input {
  margin: 5px 20px;
  padding: 10px;
  border: none;
  border-radius: 0.1em;
  animation: fadeIn 0.5s ease-in-out both;
}

#input image {
    border: none;
}

#input * {
  outline: 4px solid;
}

/* Text */
#text {
  margin: 5px;
  border: none;
  animation: fadeIn 0.5s ease-in-out both;
}

#entry {
}

#entry arrow {
  border: none;
}

/* Selected Entry */
#entry:selected {
  border: 0.11em solid;
}

#entry:selected #text {
}

#entry:drop(active) {
}
      '';
    };
  };
}
