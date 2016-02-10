Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:57308 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbcBJXQY (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Wed, 10 Feb 2016 18:16:24 -0500
Received: from localhost
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Thu, 11 Feb 2016 09:16:22 +1000
Message-ID: <1455146125.2538.231.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 21/22] ima: measure and appraise the IMA policy itself
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
	"Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org, fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Rusty Russell <rusty@rustcorp.com.au>
Date: Wed, 10 Feb 2016 18:15:25 -0500
In-Reply-To: <CACE9dm9=MRT50JgZeHrLTBVK0W+J6gYgUrzSrfzOGii_r2Ct7A@mail.gmail.com>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
	 <1454526390-19792-22-git-send-email-zohar@linux.vnet.ibm.com>
	 <CACE9dm9=MRT50JgZeHrLTBVK0W+J6gYgUrzSrfzOGii_r2Ct7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Wed, 2016-02-10 at 22:22 +0200, Dmitry Kasatkin wrote:
> On Wed, Feb 3, 2016 at 9:06 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > Add support for measuring and appraising the IMA policy itself.
> >
> > Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> 
> Acked-by: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
> 
> But from Documentation/CodingStyle
> 
> if (condition)
>     do_this();
> else
>     do_that();
> 
> This does not apply if only one branch of a conditional statement is a single
> statement; in the latter case use braces in both branches:
> 
> if (condition) {
>      do_this();
>      do_that();
> } else {
>      otherwise();
> }
> 
> 
> You have similar issue in other patches as well...
> 
> Dmitry

Ok, I'll find and fix them.  Thank you for the review!

Mimi

