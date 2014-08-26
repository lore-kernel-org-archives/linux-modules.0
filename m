Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <53FC52DA.9000303@hitachi.com>
Date: Tue, 26 Aug 2014 18:26:50 +0900
From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
MIME-Version: 1.0
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	linux-modules@vger.kernel.org
Subject: Re: Re: [RFC PATCH 4/5] module: Lock up a module when loading
 with a LOCLUP flag
References: <20140825105520.21089.26870.stgit@kbuild-fedora.novalocal> <20140825105548.21089.42883.stgit@kbuild-fedora.novalocal> <20140826053004.GG1409@intel.com>
In-Reply-To: <20140826053004.GG1409@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

(2014/08/26 14:30), Lucas De Marchi wrote:
> On Mon, Aug 25, 2014 at 10:55:48AM +0000, Masami Hiramatsu wrote:
>> Lock-up a module in kernel so that it is not removed unless
>> forcibly unload. This is done by loading a module with
>> MODULE_INIT_LOCKUP_MODULE flag (via finit_module).
>> This speeds up try_module_get by skipping refcount inc/dec for
>> the locked modules.
>>
>> Note that this flag requires to update libkmod to support it.
> 
> Patches to kmod go to linux-modules@vger.kernel.org

OK, thanks. I'll send another series for it.

> However I'm skeptical with the use case of this flag. Is this only so
> that try_module_get() is a little bit faster? How much?

For the performance side of refcounting, I guess it has no recognizable
difference compared with current one. It may be a little faster than
atomic_t ref-counter, and actual overhead will strongly depends on the
hardware configuration.
So, I can just drop this "lockup" patch from this series, if nobody
complains about using atomic_t ref-counter instead of module_ref.
I'd just like to get rid of the stop_machine() from unloading :)

> Then this would depend on a flag the user passed to modprobe which means
> only a few modules will use the flag. If you change the default
> behavior in kmod to pass this flag always, then any module the user
> wants to remove will need to be forcibly removed.

I saw an environmental variable to control it (MODPROBE_OPTIONS).
So if a user (e.g. systemtap :) ) want to make it removable, he/she
can change the env-var before running the command.

> 
> I'm leaving the rest of the patch here since I'm CC'ing linux-modules.
> 

Thank you,

-- 
Masami HIRAMATSU
Software Platform Research Dept. Linux Technology Research Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt@hitachi.com


