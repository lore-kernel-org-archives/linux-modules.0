Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:34728 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752569AbcAUV6v (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Thu, 21 Jan 2016 16:58:51 -0500
Received: by mail-ig0-f175.google.com with SMTP id ik10so133874384igb.1
        for <linux-modules@vger.kernel.org>; Thu, 21 Jan 2016 13:58:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1453410902.9549.184.camel@linux.vnet.ibm.com>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
	<20160121000300.GN11277@wotan.suse.de>
	<1453381932.9549.131.camel@linux.vnet.ibm.com>
	<5369666.tSqfcRVJfN@sifl>
	<1453410902.9549.184.camel@linux.vnet.ibm.com>
Date: Thu, 21 Jan 2016 13:58:50 -0800
Message-ID: <CAGXu5jJe9PzBR2o7wLJ7hD_X-X9_zKZUzaZmy1oyprcjCXyq6w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 08/11] module: replace copy_module_from_fd with
 kernel version
From: Kees Cook <keescook@chromium.org>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Paul Moore <pmoore@redhat.com>,
	"Luis R. Rodriguez" <mcgrof@suse.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	John Johansen <john.johansen@canonical.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	linux-security-module <linux-security-module@vger.kernel.org>,
	Kexec Mailing List <kexec@lists.infradead.org>,
	linux-modules@vger.kernel.org,
	"linux-fsdevel@vger.kernel.org" <fsdevel@vger.kernel.org>,
	David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Thu, Jan 21, 2016 at 1:15 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Thu, 2016-01-21 at 10:45 -0500, Paul Moore wrote:
>> On Thursday, January 21, 2016 08:12:12 AM Mimi Zohar wrote:
>> > Paul, Casey, Kees, Jon, Tetsuo does it make sense to consolidate the
>> > module, firmware, and kexec pre and post security hooks and have just
>> > one set of pre and post security kernel_read_file hook instead?   Does
>> > it make sense for this patch set to define the new hooks to allow the
>> > LSMs to migrate to it independently of each other?
>>
>> Well, as usual, the easiest way to both get solid feedback and actually get a
>> change accepted is to post patches to the affected LSMs.  Probably not what
>> you wanted to hear, but at least I'm honest :)
>
> Unless I'm misreading the code, it might be a lot simpler than I
> thought.  Of the three LSM hooks kernel_module_request,
> kernel_module_from_file, and kernel_fw_from_file, the only upstreamed
> LSM on any of these hooks is SELinux, which is only on the
> kernel_module_request hook.
>
> After converting the SELinux kernel_module_request hook to use the new
> kernel_read_file(),  do I then remove the three hooks?   Are we
> concerned about "minor" LSMs that have not been upstreamed that might be
> using these hooks?

It should be easy for me to port my LSM to use the new hook. No
objections in consolidating things.

(Which reminds me to resend my LSM again...)

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
