MIME-Version: 1.0
In-Reply-To: <20160816005032.28881-1-ab@fmap.me>
References: <20160816005032.28881-1-ab@fmap.me>
Date: Sun, 4 Dec 2016 19:24:43 -0800
Message-ID: <CAKi4VA+3z3dqN89yazY2UJ40KmTAHzgW0UfiGfY3odbngqmj7A@mail.gmail.com>
Subject: Re: Improvements in search of kernel modules directory
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Nikolay Amiantov <ab@fmap.me>
Cc: linux-modules <linux-modules@vger.kernel.org>, Shea Levy <shea@shealevy.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi,

On Mon, Aug 15, 2016 at 5:50 PM, Nikolay Amiantov <ab@fmap.me> wrote:
> These series of patches add more control over how kernel modules directory is
> found:
>
> * Add an environment variable which allows to override kernel modules
>   directory;
> * Allow to hardcode several paths which are searched in order for `uname -r`
>   subdirectory;
> * Add a configure option to set those paths, instead of hardcoding
>   /lib/modules.
>
> We have used the first patch in NixOS[1] for a long time to point kmod to
> kernel modules. While an environment variable is handy and has been solving our
> problems, it doesn't cover all our cases. We have two directories:

An environment variable for the library IMO is not a good option. If
you take a look on how we separate the responsibility of each
component you will see that we parse environment vars on the tools
(e.g. modprobe) not on the library.

> Additionally, while working on those it was discovered that kmod makes use of
> PATH_MAX. This constant is considered harmful[4] because it doesn't correspond
> to real possible length of filesystem paths. This can be considered a bug, but
> in those patches it was decided to follow upstream design decisions wherever
> possible and so we also use it here.

PATH_MAX is just used as a large enough buffer to hold some filenames,
module paths, etc.  Recently we introduced a new helper APIs
(scratchbuffer) to cover the cases in which we don't know the maximum
size of the buffer... Some places were converted to this new API. Few
free to submit patches using it in places it makes sense (i.e. it's
buggy to use PATH_MAX).

Lucas De Marchi
