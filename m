MIME-Version: 1.0
In-Reply-To: <xuny4lzpueku.fsf@redhat.com>
References: <1478683053.4155.8.camel@suse.com>
	<1478864601-3259-1-git-send-email-yauheni.kaliuta@redhat.com>
	<1478864601-3259-3-git-send-email-yauheni.kaliuta@redhat.com>
	<CAKi4VAJ4kQucKsj3SYZzzRJU9KfEQoDwgQfnWYDki3Gfn5UG1Q@mail.gmail.com>
	<xuny4lzpueku.fsf@redhat.com>
Date: Tue, 21 Feb 2017 21:26:46 -0800
Message-ID: <CAKi4VA+4KsvtNje0TVBfp2PtPtyLOBVvYfC5uMJZHBnynWfP=g@mail.gmail.com>
Subject: Re: [PATCH RFC 2/3] libkmod: list: export list handling functions
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: linux-modules <linux-modules@vger.kernel.org>,
	Mian Yousaf Kaukab <yousaf.kaukab@suse.com>, bjorn.andersson@linaro.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Mon, Feb 20, 2017 at 6:22 AM, Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
> Hi, Lucas!
>
>>>>>> On Mon, 13 Feb 2017 00:05:07 -0800, Lucas De Marchi  wrote:
>
>  > On Fri, Nov 11, 2016 at 3:43 AM, Yauheni Kaliuta
>  > <yauheni.kaliuta@redhat.com> wrote:
>  >> The library uses list functions to create lists internally and
>  >> provides to the clients immutable lists and only functions to
>  >> traverse them.
>  >>
>  >> It may be useful to create own lists in the kmod utilities, so
>  >> export functions for lists creation as well (as it's done for
>  >> arrays). The following functions affected (needed for the
>  >> following depmod modifications):
>  >>
>  >> kmod_list_append()
>  >> kmod_list_remove()
>  >> kmod_list_remove_data()
>  >>
>  >> The patch also adds kmod_list_data() accessor to keep the
>  >> struct kmod_list opaque.
>
>  > I don't see a use for these functions outside of the tools we provide.
>  > We don't need to export them (to external users) in order to use for
>  > our tools.  You can just make the tools include libkmod-internal.h and
>  > use that.
>
>  > In fact since you didn't update the .sym file what will happen is that
>  > external users will see a function in the header but won't be able to
>  > use it since it will not be part of the .so.
>
> Hmm, log macros redefined in this case:
>
>   CC       tools/depmod.o
> In file included from tools/kmod.h:42:0,
>                  from tools/depmod.c:42:
> tools/log.h:31:0: warning: "ERR" redefined
>  #define ERR(...) log_printf(LOG_ERR, __VA_ARGS__)
>
> In file included from tools/depmod.c:40:0:
> ./libkmod/libkmod-internal.h:29:0: note: this is the location of the previous definition
>  #  define ERR(ctx, arg...) kmod_log_cond(ctx, LOG_ERR, ## arg)
>
>
> Would include libkmod-internal.h, then undef then, then include kmod.h be
> acceptable?

This is the approach taken by testsuite. So, yes, it's fine for now.

Since we always include with order system headers, lib headers, local
headers, we could even make the undef on tools/log.h, so inside the
tools we use our local logging macros.

Lucas De Marchi
