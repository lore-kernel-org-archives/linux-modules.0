Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B421535BDAD
	for <linux-modules@vger.kernel.org>; Fri, 13 Mar 2026 17:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773421633; cv=none; b=F/ViDu09wVki80NlHL5aveRTNqPke0ZvM1+xApd/D+Cq1uLLz7I3kSuehISCc/t7T7LgKI4GLfWPu51+mcCE4WeqJhjKgOKOnvvbVPAJNEhJQb9i+7Obvz/ySE1/KdiyCcCqqrvvHlC079VLr9Rd91clX6+G1/7CyW5mjZ4BdC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773421633; c=relaxed/simple;
	bh=z7AGwqb57CwAMqE9fS+3ykGurf6LPqrzuywb5yXOKzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOL2YdUelRO0UIGlHMvz3VqhHe+x9iDTGKinzVKJaYDIFu/fetEAGOW835GwrevfFdRy9xeYQAsmozl2aCQ7b0CLj2PBXpUnlpTVtQaE5+ZV3LLV22W7Y3vmdNP9O7jBdEhMsP1snDvhk/sBkq75xfhHX2n3ho1R/qOlVQm5M+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H+mo1k8/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H+mo1k8/"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2aea4ebb048so3715ad.1
        for <linux-modules@vger.kernel.org>; Fri, 13 Mar 2026 10:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773421632; x=1774026432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kcULnJOLAuZh87RKAsbNLZQYw5Yxpz2q2AsZGTy7iU8=;
        b=H+mo1k8/iHELVGCO1YKNn2bZEyDoPnA7xtKtqnllTeYFZkb0U3P7BgrkQWg2PASxya
         F7/M9Ehvn4GkRobu+Wdt6Q98audhSAYnPEhEPnpVrDrwodZ+/NImBeaHsGVOBJ5NFfHr
         uiM1Ou4mBM3zFtc998Wtj9lbS+Gx7pBGNzfU79rjUbSeKOjDA7TAn7l8h06BQroOF5h7
         IwNVNzt/FA5yOxuyhoNbww4KDvCvt5N7/NU2f1AH60EvDpmOtyH8m7cvzhq1es/NNk1u
         kJWuJ+mIJvZBEVarCGiSh7f9GO3gi8Hr9cp1cTfWhWa0kk086WOL1biIBWzpCWQH1Qp2
         TWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773421632; x=1774026432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kcULnJOLAuZh87RKAsbNLZQYw5Yxpz2q2AsZGTy7iU8=;
        b=TlGqEFqq1C4z00Bf6VaGCgPKpuMxWdLyjQoJc5awH2bIjDnJWA9YSUsqgIWJKjLn/H
         gqp+udbebiKh5CKD9sO2Ul1EYtJRl6lFhK+VeBaGmq732TYKbcXaGJS1GFcKG5/8s92r
         G7Vkfxpm/o0Yrqc/B2LhAjy1rdQc7hwjcp8fE69WldxYG1Jb5eCmu1sWTPKSnrM4frcK
         /d/r8Ya+Kq9I6V+uFAKXaZl2QtC/rvJ/QfEH04n3xO/B4/7zFrQtCk98GRWjWenUhYNC
         6mUZkfCYNZreYIuXbOh178sIdxIq0sJD0PjYg1tt/11e45SjvLbuLQcLw79jIH/clGkB
         5kgA==
X-Gm-Message-State: AOJu0YxtRMUdV+P5VxEnDeKZ8iYHcx/C3xERJWFFYUowq1CJCniNuDC3
	5TAWYmaC2MsZWsZ8uu4BnP1m/ur+CgsKweoHrlOyrTSYqFKnfSIi5cGk06SEbzNlrA==
X-Gm-Gg: ATEYQzxoC95VwJzhwYW7LmKo63C2SjqIQW2W6/P/oF4eZMhA3wTu5GQAjousNdlhhgK
	Ci1ot2lktFjfuNGFU/INrnNNf14zs9KPWw20zuFlsEGghj3DNpKn4Rv7yoWp5XECQDBfu0IJOYE
	Bz/AhNyT+1HP6GUqZYn//wgBunILxAmzasHFAqqJ60qMeNkCVWQtO39i8ndDtFBwrdla/YZnMNB
	zUcyMj5xPheIbXeysV1vLDiW/CrXrc0s2edJ6ph7nBzuZkpO59Pn31OU3PSReYIlH5r8wJJ9Lm5
	mGiVPGionhefuqAHn+UApvMEuLagbyZUsfc9UE2eLRGk9e8vLjfIPtbvb1CHZTNiU/J+gwTqIDT
	d0rbhqELzcItNkRQXtrz0PQ3QrHnPcRFfDPpr1zH37qYnMLhxhNrRZhrMgN8+HldjLelILmp72U
	CDy1PYeGsy0iAA/pUGsXPAtF0uaKevweXcoPbmG9+aZXXRP0uVcCkg4B6jly09Y2Ib4OA=
X-Received: by 2002:a17:902:ccc4:b0:2a1:3cdc:7720 with SMTP id d9443c01a7336-2aecd668c28mr2837265ad.21.1773421631684;
        Fri, 13 Mar 2026 10:07:11 -0700 (PDT)
Received: from google.com (197.23.125.34.bc.googleusercontent.com. [34.125.23.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece5c1465sm39467795ad.21.2026.03.13.10.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 10:07:11 -0700 (PDT)
Date: Fri, 13 Mar 2026 17:07:06 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Shyam Saini <shyamsaini@linux.microsoft.com>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] module: remove MODULE_VERSION()
Message-ID: <20260313170706.GC213695@google.com>
References: <2026031341-evolve-repeater-987b@gregkh>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026031341-evolve-repeater-987b@gregkh>

Hi Greg,

On Fri, Mar 13, 2026 at 03:20:42PM +0100, Greg Kroah-Hartman wrote:
> Module "versions" do not make sense as the kernel is built all at once,
> the "version" is the overall kernel version number, so modules can not
> really be described as having a unique version given that they rely on
> the infrastructure of the whole kernel.
> 
> For now, just make this an "empty" define, to keep existing code
> building properly as the tree is slowly purged of the use of this over
> time.
> 
> This macro will be removed entirely in the future when there are no
> in-tree users.
> 
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Petr Pavlu <petr.pavlu@suse.com>
> Cc: Daniel Gomez <da.gomez@kernel.org>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: Aaron Tomlin <atomlin@atomlin.com>
> Cc: Shyam Saini <shyamsaini@linux.microsoft.com>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Thorsten Blum <thorsten.blum@linux.dev>
> Cc: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  include/linux/module.h | 56 +++++++++---------------------------------
>  kernel/params.c        | 30 ----------------------
>  2 files changed, 11 insertions(+), 75 deletions(-)

This certainly solves our version problems! I noticed there are a
couple of __modver references left in the code base after this patch,
which can be dropped too, and you can also remove the version field
from struct module at the same time.

Sami
