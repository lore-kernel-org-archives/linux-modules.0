MIME-Version: 1.0
In-Reply-To: <1442004956-3868-2-git-send-email-labbott@fedoraproject.org>
References: <1442004956-3868-1-git-send-email-labbott@fedoraproject.org>
	<1442004956-3868-2-git-send-email-labbott@fedoraproject.org>
Date: Sat, 12 Sep 2015 15:27:21 -0300
Message-ID: <CAKi4VAKzR+=Gnk1EGwe6a_Rmg5vA1dgLvZ9mwVcBrzjd+Ag-Pg@mail.gmail.com>
Subject: Re: [PATCH 1/4] build: Properly check for Cython
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Laura Abbott <labbott@fedoraproject.org>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>, linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Fri, Sep 11, 2015 at 5:55 PM, Laura Abbott <labbott@fedoraproject.org> wrote:
>
> Cython is necessary to compile if --enable-python is used.
> Currently, the configuration just sets Cython to ':' if
> it isn't found. ':' is a valid command which results in
> confusing build errors:
>
>   CCLD     libkmod/libkmod.la
>   CCLD     libkmod/libkmod-internal.la
> ar: `u' modifier ignored since `D' is the default (see `U')
>   CYTHON  libkmod/python/kmod/kmod.c
>   CC       libkmod/python/kmod/libkmod_python_kmod_kmod_la-kmod.lo
> gcc: error: ./libkmod/python/kmod/kmod.c: No such file or directory
> gcc: fatal error: no input files
>
> Explicitly check if cython is available and then error out
> if it isn't found.
> ---

Since we distribute the  generated python files, cython is only needed
on "building from git tree" cases, not for packages.


Lucas De Marchi
