MIME-Version: 1.0
In-Reply-To: <54E5795C.5050804@mentor.com>
References: <1424177796-17923-1-git-send-email-harish_kandiga@mentor.com>
	<CAKi4VA+nJknEwkQfUWf0VbcEMzzz3uHwwNe8OuWQOi-K0sWxjQ@mail.gmail.com>
	<874mqjuaky.fsf@rustcorp.com.au>
	<CAKi4VAKpzUcakX+BY8dYE8Jx4BUOqy_-LZWH5gJWtwn3EdbE0g@mail.gmail.com>
	<87vbiysv1v.fsf@rustcorp.com.au>
	<CAKi4VAKc_zrPptt2ZKT_Jj8bLdL1bt0emhtEuodV2WKkas9ZOw@mail.gmail.com>
	<54E5795C.5050804@mentor.com>
Date: Thu, 19 Feb 2015 08:30:40 -0200
Message-ID: <CAKi4VA+ceEsQm30+4q_hvgtm2Uwo1cJSQdJErUh6hsd=fwbe0g@mail.gmail.com>
Subject: Re: [PATCH] libkmod-module: Remove directory existence check for KMOD_MODULE_BUILTIN
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Harish Jenny Kandiga Nagaraj <harish_kandiga@mentor.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-modules <linux-modules@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>, greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Thu, Feb 19, 2015 at 3:49 AM, Harish Jenny Kandiga Nagaraj
<harish_kandiga@mentor.com> wrote:
>> Harrish, in your patch if you just change the "return
>> KMOD_MODULE_BUILTIN;" to "return KMOD_MODULE_COMING;" does it work?
>
> Yes. Returning KMOD_MODULE_COMING instead of KMOD_MODULE_BUILTIN  works. =
The built-in modules are handled by looking at the modules.builtin index fi=
le. Is there any chance of returning KMOD_MODULE_COMING for builti-in modul=
es? If it does not have any impact, then the fix should be fine.

well... you're not returning KMOD_MODULE_COMING for a builtin module.
Having the directory /sys/module/<name> and not the initstate could be
either that the module is builtin or that there's a race while loading
the module and it's in the coming state. However since we use the
index to decide if this module is builtin in the beginning of this
function, here it can only be the second case.

However... mod->builtin in the beginning of this function is only set
if the module is created by a lookup rather than from name or from
path.... maybe here we need to actually fallback to the index rather
than the cached value, otherwise this test would fail (considering
"vt" is builtin):

kmod_module_new_from_name(ctx, "vt", &mod);
kmod_module_get_initstate(mod, &state);


> Do I need to send a separate patch ?

I was hoping it would be a oneliner, but it isn't. If you are going to
send a patch, please add the necessary checks for the builtin index.
Otherwise I can take a look on this until the end of this week.

--=20
Lucas De Marchi
