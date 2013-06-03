Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-vb0-f43.google.com ([209.85.212.43]:35627 "EHLO
	mail-vb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757862Ab3FCNdL (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Mon, 3 Jun 2013 09:33:11 -0400
Received: by mail-vb0-f43.google.com with SMTP id e15so1105373vbg.30
        for <linux-modules@vger.kernel.org>; Mon, 03 Jun 2013 06:33:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <51ABCCBC.8010807@openelec.tv>
References: <51AB5F72.6020307@openelec.tv> <51AB7941.2060505@opensuse.org>
 <51AB80D9.6090409@openelec.tv> <20130602173642.GA1138@kroah.com> <51ABCCBC.8010807@openelec.tv>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Mon, 3 Jun 2013 10:32:50 -0300
Message-ID: <CAMOw1v4WuH2GZXVR1+vsWf-EGiCJN3=v9WfmqTD_cEhPbh3z+g@mail.gmail.com>
Subject: Re: [systemd-devel] systemd fails to build with static kmod library
To: Stephan Raue <mailinglists@openelec.tv>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	systemd-devel@lists.freedesktop.org,
	linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Sun, Jun 2, 2013 at 7:52 PM, Stephan Raue <mailinglists@openelec.tv> wrote:
> Am 02.06.2013 19:36, schrieb Greg KH:
>>
>> On Sun, Jun 02, 2013 at 07:28:57PM +0200, Stephan Raue wrote:
>>
>>> i dont agree, i some cases it makes sense. since udev is included in
>>> systemd and udev has now its own buildins for the modprobe stuff it
>>> should be possible to use kmod statically linked, esp. if no other
>>> installed program uses kmod (and for our usage the kmod userspace
>>> binarys are not neccessary)
>>
>>
>> If you are so worried about other programs / users calling kmod, then
>> just build your needed kernel modules into the kernel and don't use any
>> kernel modules at all.
>>
> i am not much worried about this, but more about the comment "Do not use
> static linking, with systemd, ever, in fact do not use with any other
> component.". Statically linking works for so many programs and even kmod
> supports the "--enable-static" configure option. So basically i tried to
> report this broken behavior, because i never seen a statement like "dont
> link anything statically against systemd"

It's not advised to do it, so it's up to you to fix it in your custom
build. Basically what you could do either of these in libkmod.a:

1) Rename the clashing symbols with objcopy (use --redefine-sym option)
2) Localize symbols with objcopy (--localize-hidden)
3) Extract the .o objects (ar -x) and relink them into a single .o (ld
-r). Then turn it into a .a using libtool --static

If you integrate (2) or (3) nicely in the build system I think it
could be acceptable upstream.

Another option is... while building systemd, you could achieve
something similar to (2) above without the trouble of modifying
libkmod.a by passing "-Wl,--exclude-libs,ALL" in LDFLAGS (untested).


Lucas De Marchi
