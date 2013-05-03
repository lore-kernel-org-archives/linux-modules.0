Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-ve0-f171.google.com ([209.85.128.171]:34476 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287Ab3ECUbm (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Fri, 3 May 2013 16:31:42 -0400
Received: by mail-ve0-f171.google.com with SMTP id oy12so1909736veb.30
        for <linux-modules@vger.kernel.org>; Fri, 03 May 2013 13:31:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130427044752.GF18066@chengwei-workstation.bj.intel.com>
References: <1366791595-5293-1-git-send-email-chengwei.yang@intel.com>
 <1366791595-5293-3-git-send-email-chengwei.yang@intel.com>
 <CAMOw1v7=_k6Vkq7+ju=hvcWyzsrWkDkoUBD0KsUbuAXF8O3YEw@mail.gmail.com>
 <20130427023827.GB18066@chengwei-workstation.bj.intel.com>
 <CAMOw1v4aQK6Ji_omLfR+tEeOEsG3pipzDT=pWAkgsfA97=crGA@mail.gmail.com>
 <20130427040224.GD18066@chengwei-workstation.bj.intel.com> <20130427044752.GF18066@chengwei-workstation.bj.intel.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Fri, 3 May 2013 17:31:21 -0300
Message-ID: <CAMOw1v7+pBhFE0FJjogvmvpGcZM2-Zsp56dOp_JQ5MQVdbGVww@mail.gmail.com>
Subject: Re: [PATCH 2/2] Add document about exported enum definitions
To: Yang Chengwei <chengwei.yang@intel.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Hi Yang,

On Sat, Apr 27, 2013 at 1:47 AM, Yang Chengwei <chengwei.yang@intel.com> wrote:
> On Sat, Apr 27, 2013 at 12:02:24PM +0800, Yang Chengwei wrote:
>> On Sat, Apr 27, 2013 at 12:24:43AM -0300, Lucas De Marchi wrote:
>> > On Fri, Apr 26, 2013 at 11:38 PM, Yang Chengwei <chengwei.yang@intel.com> wrote:
>> > >
>> > > I feel sorry to say that's true from my understand. It recognize
>> > > typedef'ed enum and enum _foo {...}; In the later the document generated
>> > > also say enum foo (no underscore), it's wrong if there is no typedef
>> > > enum _foo foo since in fact no enum foo here.
>> > >
>> > > For detail, please refer to https://bugzilla.gnome.org/show_bug.cgi?id=657444
>> > >
>> > > So due to this limitation, the workaround I could say is use typedef as
>> > > below:
>> > >
>> > > typedef enum foo {
>> > >     ...
>> > > } foo;
>> > >
>> > > Is that acceptable to you? If no, I think I'll drop the second patch
>> > > which try to document the exported enums.
>> >
>> > It's not acceptable in the public header and throughout the source
>> > code. Since this is a limitation of gtk-doc and that in C you can add
>> > the typedef anywhere, what could be done is to document these enums
>> > hidden in the end of the respective .c file. And throughout the source
>> > code we continue to use "enum ...". So you wouldn't touch the header,
>> > but would have this, for example in the ende of
>> > libkmod/libkmod-module.c:
>> >
>> >
>> > /** kmod_module_probe_flags:
>> >  * @KMOD_PROBE_FORCE_VERMAGIC: remove version magic to force insert module
>> >  * @KMOD_PROBE_FORCE_MODVERSION: remove interface version to force insert module
>> >  * ...
>> >  */
>> > typedef enum kmod_module_probe_flags kmod_module_probe_flags;
>>
>> Hmm, I just checked the latest gtk-doc git repo. It has very limit
>> support for enum. Say it support:
>>
>> 1. plain enum named with underscore prefix.
>> enum _foo {
>>     ...
>> };
>>
>> 2. typedef'ed enum
>> typedef enum foo {
>>     ...
>> } foo;
>>
>> 3. another kind of typedef'ed enum
>> typedef enum _foo foo;
>> enum _foo {
>>     ...
>> };
>>
>> Note the unerscore used here. So it doesn't support
>> typedef enum kmod_module_probe_flags kmod_module_probe_flags; :-(.
>>
>> If I understand correctly, your goal is do not use typedef'ed enum like
>> foo but enum foo in source code. I agree with you and I think it's fine
>> with below:
>>
>> typedef enum foo {
>>     ...
>> } foo;
>>
>> We can still use "enum foo" in any place else. But unfortuately, user
>> will see that in docuement.
>
> In addition, the document shows in
>
> typedef enum {
>     ...
> } foo;
>
> rather than how it write in header
>
> typedef enum foo {
>     ...
> } foo;
>
> So the user will get clue to always use "foo" rather than "enum foo",
> this just violate kmod coding style! I think I'm giving up the second
> patch. :-(, any suggestion?

In the header we can't add the typedefs, otherwise this would be
exported to the users and part of the API. If gtk-doc doesn't support
this:

libkmod.h:
enum kmod_filter {
 ....
}

libkmod-module.c:

/**
 * doc...
 */
typedef enum kmod_filter kmod_filter;


Then I'd say to add your enum documentation on top of the functions
where they are used in .c. Then later either we figure out a way to
make it appear on gtk-doc (patching gtk-doc), or move away to another
better tool for generating doc, or we live with this documented only
in the .c file while the first options are not feasible.

I think the documentation your patch brings is way more important than
the way it's presented to the user.

regards,
Lucas De Marchi
