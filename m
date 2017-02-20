Return-Path: <yauheni.kaliuta@redhat.com>
From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>,
        Mian Yousaf Kaukab <yousaf.kaukab@suse.com>,
        bjorn.andersson@linaro.org
Subject: Re: [PATCH RFC 2/3] libkmod: list: export list handling functions
References: <1478683053.4155.8.camel@suse.com>
	<1478864601-3259-1-git-send-email-yauheni.kaliuta@redhat.com>
	<1478864601-3259-3-git-send-email-yauheni.kaliuta@redhat.com>
	<CAKi4VAJ4kQucKsj3SYZzzRJU9KfEQoDwgQfnWYDki3Gfn5UG1Q@mail.gmail.com>
Date: Mon, 20 Feb 2017 16:22:41 +0200
In-Reply-To: <CAKi4VAJ4kQucKsj3SYZzzRJU9KfEQoDwgQfnWYDki3Gfn5UG1Q@mail.gmail.com>
	(Lucas De Marchi's message of "Mon, 13 Feb 2017 00:05:07 -0800")
Message-ID: <xuny4lzpueku.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-modules.vger.kernel.org>

Hi, Lucas!

>>>>> On Mon, 13 Feb 2017 00:05:07 -0800, Lucas De Marchi  wrote:

 > On Fri, Nov 11, 2016 at 3:43 AM, Yauheni Kaliuta
 > <yauheni.kaliuta@redhat.com> wrote:
 >> The library uses list functions to create lists internally and
 >> provides to the clients immutable lists and only functions to
 >> traverse them.
 >> 
 >> It may be useful to create own lists in the kmod utilities, so
 >> export functions for lists creation as well (as it's done for
 >> arrays). The following functions affected (needed for the
 >> following depmod modifications):
 >> 
 >> kmod_list_append()
 >> kmod_list_remove()
 >> kmod_list_remove_data()
 >> 
 >> The patch also adds kmod_list_data() accessor to keep the
 >> struct kmod_list opaque.

 > I don't see a use for these functions outside of the tools we provide.
 > We don't need to export them (to external users) in order to use for
 > our tools.  You can just make the tools include libkmod-internal.h and
 > use that.

 > In fact since you didn't update the .sym file what will happen is that
 > external users will see a function in the header but won't be able to
 > use it since it will not be part of the .so.

Hmm, log macros redefined in this case:

  CC       tools/depmod.o
In file included from tools/kmod.h:42:0,
                 from tools/depmod.c:42:
tools/log.h:31:0: warning: "ERR" redefined
 #define ERR(...) log_printf(LOG_ERR, __VA_ARGS__)
 
In file included from tools/depmod.c:40:0:
./libkmod/libkmod-internal.h:29:0: note: this is the location of the previous definition
 #  define ERR(ctx, arg...) kmod_log_cond(ctx, LOG_ERR, ## arg)


Would include libkmod-internal.h, then undef then, then include kmod.h be
acceptable?



-- 
WBR,
Yauheni Kaliuta
