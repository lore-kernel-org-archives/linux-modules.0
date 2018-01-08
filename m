MIME-Version: 1.0
In-Reply-To: <20180103222924.26347-1-lucas.demarchi@intel.com>
References: <20180103222924.26347-1-lucas.demarchi@intel.com>
Date: Mon, 8 Jan 2018 13:33:48 -0800
Message-ID: <CAKi4VALczk_wgayysXRJSzk4SWwzP7hDgsoO7_21Geybo83b4A@mail.gmail.com>
Subject: Re: [PATCH 0/6] prepare for release
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-modules <linux-modules@vger.kernel.org>,
	Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-modules.vger.kernel.org>

On Wed, Jan 3, 2018 at 2:29 PM, Lucas De Marchi
<lucas.demarchi@intel.com> wrote:
> I already applied the first patch since I was thinking about just
> quickly testing in a pristine environment before releasing.
> However I went ahead and 1) added support for more than one distro
> using mkosi and 2) debugged why the testsuite was failing for me.
>
> After this I think we are safe to do a new release.
>
>
> Lucas De Marchi (6):
>   build: add mkosi hooks
>   build: use tool from configure
>   testsuite: generalize mkosi support for other distros
>   testsuite: add Fedora's mkosi configuration
>   testsuite: add missing error handling
>   testsuite: explain why overriding function may fail

All patches applied.

Lucas De Marchi

>
>  Makefile.am                  | 10 ++++++++++
>  configure.ac                 |  1 +
>  testsuite/init_module.c      |  9 +++++++--
>  testsuite/mkosi/.gitignore   |  3 +++
>  testsuite/mkosi/mkosi.arch   | 25 +++++++++++++++++++++++++
>  testsuite/mkosi/mkosi.build  | 38 ++++++++++++++++++++++++++++++++++++++
>  testsuite/mkosi/mkosi.fedora | 26 ++++++++++++++++++++++++++
>  testsuite/testsuite.h        |  2 ++
>  8 files changed, 112 insertions(+), 2 deletions(-)
>  create mode 100644 testsuite/mkosi/.gitignore
>  create mode 100644 testsuite/mkosi/mkosi.arch
>  create mode 100755 testsuite/mkosi/mkosi.build
>  create mode 100644 testsuite/mkosi/mkosi.fedora
>
> --
> 2.14.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-modules" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Lucas De Marchi
