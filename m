Return-Path: <SRS0=RtG0=2S=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC861C2D0C8
	for <linux-modules@archiver.kernel.org>; Sat, 28 Dec 2019 22:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA9E72173E
	for <linux-modules@archiver.kernel.org>; Sat, 28 Dec 2019 22:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbfL1W77 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sat, 28 Dec 2019 17:59:59 -0500
Received: from mga02.intel.com ([134.134.136.20]:6367 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbfL1W76 (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Sat, 28 Dec 2019 17:59:58 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Dec 2019 14:59:57 -0800
X-IronPort-AV: E=Sophos;i="5.69,368,1571727600"; 
   d="scan'208";a="392898610"
Received: from patrickn-mobl.amr.corp.intel.com (HELO ldmartin-desk1) ([10.254.14.145])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Dec 2019 14:59:57 -0800
Date:   Sat, 28 Dec 2019 14:59:51 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     Lucas De Marchi <lucas.de.marchi@gmail.com>,
        linux-modules <linux-modules@vger.kernel.org>
Subject: Re: [PATCH] libkmod-module: convert return value from system() to
 errno
Message-ID: <20191228225951.q6g4nyjobpbsfjao@ldmartin-desk1>
References: <f8c64aed-b4a1-e43f-ed4b-f99236932477@gmail.com>
 <CAKi4VAK3pGJt8qA6CVrkwJOa5JLGtc63hWM0UZngp_qJb40jcw@mail.gmail.com>
 <8b27685f-138f-2a5e-3247-2ed2a855b7db@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <8b27685f-138f-2a5e-3247-2ed2a855b7db@gmail.com>
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Dec 24, 2019 at 11:54:58AM +0200, Topi Miettinen wrote:
>On 24.12.2019 4.54, Lucas De Marchi wrote:
>>On Mon, Dec 23, 2019 at 9:07 AM Topi Miettinen <toiwoton@gmail.com> wrote:
>>>
>>>Don't use exit status of a command directly as errno code, callers
>>>will be confused.
>>>
>>>Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
>>>---
>>>   libkmod/libkmod-module.c | 8 +++++---
>>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>>
>>>diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
>>>index 8044a8f..6031d80 100644
>>>--- a/libkmod/libkmod-module.c
>>>+++ b/libkmod/libkmod-module.c
>>>@@ -983,11 +983,13 @@ static int command_do(struct kmod_module *mod,
>>>const char *type,
>>>          if (err == -1 || WEXITSTATUS(err)) {
>>>                  ERR(mod->ctx, "Error running %s command for %s\n",
>>>                                                                  type,
>>>modname);
>>>-               if (err != -1)
>>>-                       err = -WEXITSTATUS(err);
>>
>>I don't think we actually care about differentiating them. So just a plain
>>return -EINVAL;  here would suffice, makes sense?
>
>I think it would lose potentially valuable information. For example 
>EPERM could tell the system administrator of a problem with MAC 
>configuration preventing execution of the shell, ENOENT could show 
>that the shell or shared libraries are missing and so forth.

makes sense, but we take decisions on the callers depending on the
return value. I don't want to mix that with return values from the
commands executed. E.g. if the command returned EEXIST the caller would
treat a fail differently.

I think it would be good here to give different error messages and
always return -EINVAL. I'm thinking on squashing the following diff,
what do you think?


diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 6031d80..714ee21 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -980,13 +980,16 @@ static int command_do(struct kmod_module *mod, const char *type,
  	err = system(cmd);
  	unsetenv("MODPROBE_MODULE");
  
-	if (err == -1 || WEXITSTATUS(err)) {
-		ERR(mod->ctx, "Error running %s command for %s\n",
-								type, modname);
-		if (err != -1) /* nonzero exit status: something bad happened */
-			return -EINVAL;
-		else /* child process could not be created */
-			return -errno;
+	if (err == -1) {
+		ERR(mod->ctx, "Could not run %s command '%s' for module %s: %m\n",
+		    type, cmd, modname);
+		return -EINVAL;
+	}
+
+	if (WEXITSTATUS(err)) {
+		ERR(mod->ctx, "Error running %s command '%s' for module %s: retcode %d\n",
+		    type, cmd, modname, WEXITSTATUS(err));
+		return -EINVAL;
  	}
  
  	return 0;


thanks
Lucas De Marchi
