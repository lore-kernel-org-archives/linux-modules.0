Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e28smtp07.in.ibm.com ([125.16.236.7]:46524 "EHLO
	e28smtp07.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753464AbcBHVMf (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Mon, 8 Feb 2016 16:12:35 -0500
Received: from localhost
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Tue, 9 Feb 2016 02:42:32 +0530
Message-ID: <1454965936.3037.34.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 20/22] ima: load policy using path
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
Cc: Petko Manolov <petkan@mip-labs.com>,
	"linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
	"Luis R. Rodriguez" <mcgrof@suse.com>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
	"fsdevel@vger.kernel.org" <fsdevel@vger.kernel.org>,
	David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>
Date: Mon, 08 Feb 2016 16:12:16 -0500
In-Reply-To: <C2D7A727C393B644B70DF4B4DCFB60B9C8A882@lhreml507-mbx.china.huawei.com>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
	 <1454526390-19792-21-git-send-email-zohar@linux.vnet.ibm.com>
	 <20160207195945.GG17321@localhost>
	 <C2D7A727C393B644B70DF4B4DCFB60B9C8A843@lhreml507-mbx.china.huawei.com>
	,<20160208103505.GA7931@bender.nucleusys.com>
	 <C2D7A727C393B644B70DF4B4DCFB60B9C8A882@lhreml507-mbx.china.huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Mon, 2016-02-08 at 10:45 +0000, Dmitry Kasatkin wrote:

> > > @@ -286,9 +322,12 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
> > >       result = mutex_lock_interruptible(&ima_write_mutex);
> > >       if (result < 0)
> > >               goto out_free;
> > > -     result = ima_parse_add_rule(data);
> > > -     mutex_unlock(&ima_write_mutex);
> > >
> > > +     if (data[0] == '/')
> >
> > >It seems that if we feed relative path to ima_policy the update will fail...
> >
> > Yes, i think it is always a good idea to pass absolute path.
> 
> What if we at least emit a warning so people know what's wrong?

The next patch "ima: measure and appraise the IMA policy itself" adds
the following.  Is a failure message enough?

+       else if (ima_appraise & IMA_APPRAISE_POLICY) {
+               pr_err("IMA: signed policy required\n");
+               integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
+                                   "policy_update", "signed policy
required",
+                                   1, 0);
+               if (ima_appraise & IMA_APPRAISE_ENFORCE)
+                       result = -EACCES;
+       } else
                result = ima_parse_add_rule(data);

> 
>                 Petko
> 
> DK: May be a good idea to print that loading policy by path or not.

Are we including the pathname?  Are you suggesting a log or audit
message?

Mimi

