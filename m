Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:34842 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752485AbcAUUUG (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Thu, 21 Jan 2016 15:20:06 -0500
Received: from localhost
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Fri, 22 Jan 2016 06:20:04 +1000
Message-ID: <1453407534.9549.154.camel@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2 00/11] vfss: support for a common kernel file
 loader
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: linux-security-module@vger.kernel.org, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org, fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Fengguang Wu <fengguang.wu@intel.com>
Date: Thu, 21 Jan 2016 15:18:54 -0500
In-Reply-To: <20160121201653.GD20964@wotan.suse.de>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
	 <20160121201653.GD20964@wotan.suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Thu, 2016-01-21 at 21:16 +0100, Luis R. Rodriguez wrote:
> On Mon, Jan 18, 2016 at 10:11:15AM -0500, Mimi Zohar wrote:
> >
> > The latest version of these patches can be found in the next-kernel-read-v2
> > branch of:
> > git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
> > 
> > [1] Taken from Luis Rodriguez's wiki -
> > http://kernelnewbies.org/KernelProjects/common-kernel-loader
> 
> Did 0-day bot get a chance to test this tree? If not can it
> be added ?

Yes, I get the notifications.

Mimi

