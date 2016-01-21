Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148]:44261 "EHLO
	e23smtp06.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162AbcAUVQM (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Thu, 21 Jan 2016 16:16:12 -0500
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Fri, 22 Jan 2016 07:16:10 +1000
Message-ID: <1453410902.9549.184.camel@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2 08/11] module: replace copy_module_from_fd with
 kernel version
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Paul Moore <pmoore@redhat.com>
Cc: "Luis R. Rodriguez" <mcgrof@suse.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	John Johansen <john.johansen@canonical.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	linux-security-module@vger.kernel.org, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org, fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date: Thu, 21 Jan 2016 16:15:02 -0500
In-Reply-To: <5369666.tSqfcRVJfN@sifl>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
	 <20160121000300.GN11277@wotan.suse.de>
	 <1453381932.9549.131.camel@linux.vnet.ibm.com> <5369666.tSqfcRVJfN@sifl>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Thu, 2016-01-21 at 10:45 -0500, Paul Moore wrote:
> On Thursday, January 21, 2016 08:12:12 AM Mimi Zohar wrote:
> > Paul, Casey, Kees, Jon, Tetsuo does it make sense to consolidate the
> > module, firmware, and kexec pre and post security hooks and have just
> > one set of pre and post security kernel_read_file hook instead?   Does
> > it make sense for this patch set to define the new hooks to allow the
> > LSMs to migrate to it independently of each other?
> 
> Well, as usual, the easiest way to both get solid feedback and actually get a 
> change accepted is to post patches to the affected LSMs.  Probably not what 
> you wanted to hear, but at least I'm honest :)

Unless I'm misreading the code, it might be a lot simpler than I
thought.  Of the three LSM hooks kernel_module_request,
kernel_module_from_file, and kernel_fw_from_file, the only upstreamed
LSM on any of these hooks is SELinux, which is only on the
kernel_module_request hook.

After converting the SELinux kernel_module_request hook to use the new
kernel_read_file(),  do I then remove the three hooks?   Are we
concerned about "minor" LSMs that have not been upstreamed that might be
using these hooks?

Mimi

