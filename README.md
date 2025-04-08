# inf-gptel

`inf-gptel` provides a `comint-mode` based interface to interact with [Gptel](https://github.com/karthink/gptel) in Emacs.

![demo](https://gist.githubusercontent.com/tttuuu888/bd9f36d1afa8b94ea66e45bec6ccabed/raw/4061d5bc988922968d9ae53ddf368b39abe75704/inf-gptel-demo.gif)

## Installation

Install `inf-gptel.el` manually or via vc-use-package (emacs 30):

```emacs-lisp
(use-package inf-gptel
  :vc (:url "https://github.com/tttuuu888/inf-gptel" :branch "main"))
```

## Usage

Add the following to your Emacs configuration:

```emacs-lisp
(require 'inf-gptel)
```

Then run the interactive shell with:

    M-x inf-gptel
