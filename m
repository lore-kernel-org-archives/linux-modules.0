Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:50005 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759002AbcAUNUe (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Thu, 21 Jan 2016 08:20:34 -0500
Received: from localhost
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Thu, 21 Jan 2016 23:20:32 +1000
Message-ID: <1453382376.9549.138.camel@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2 01/11] ima: separate 'security.ima' reading
 functionality from collect
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>,
	"Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org, fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Thu, 21 Jan 2016 08:19:36 -0500
In-Reply-To: <CACE9dm_3=CNe-PwWaLk1JCNrFjwJLkxuV13x_jdgPu7wQTKs7w@mail.gmail.com>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
	 <1453129886-20192-2-git-send-email-zohar@linux.vnet.ibm.com>
	 <CACE9dm_3=CNe-PwWaLk1JCNrFjwJLkxuV13x_jdgPu7wQTKs7w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Tue, 2016-01-19 at 22:00 +0200, Dmitry Kasatkin wrote:
> Hi Mimi,
> 
> Please change
> 
> Signed-off-by: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>

I'll make the change here and in the other patches as well.

Mimi

