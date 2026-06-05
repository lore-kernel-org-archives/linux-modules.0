Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5726C3AA9D9
	for <linux-modules@vger.kernel.org>; Fri,  5 Jun 2026 18:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684613; cv=none; b=eXextXO2OoTfG5f3DH5nWsGu8rHbCD1WZgnOtgGfLRxJd/4b5yyMKdqFKu/JsvKyhE4k0cQZk3eiddm5CPrLDqC5TGZI36vLfl5So6etbLV6EwxT106qGbROwqp7ISd03Heq3p0mBfvg8+8LXeyXJeGBXize+VBqm22G1pB1pEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684613; c=relaxed/simple;
	bh=ZQHe0J07CmP23BW2U5EKlaB3TPIrDh2NZlEnsiDNxHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ow88WaZKWdEkH90pPkO4DtwZzGImvm/eFtNozcGWXik0gxN5MYiFYA6I9MfreA1fMWAK372ko+Xa01JuX2JWTKys2E+JmdF77GziiPrzkFC7+pR0VC4QMDlG29PjdV574H5xiYPVwrd4w/qIoJ3rIfkv+7W1TJ2ez3Lii/YfNaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JhzoTCFM; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JhzoTCFM"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2bf2d865383so123265ad.1
        for <linux-modules@vger.kernel.org>; Fri, 05 Jun 2026 11:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780684612; x=1781289412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P13RElyEY77N682sCtZ4HPH2+wcRcMGtUhEt/2n1PrE=;
        b=JhzoTCFMqXHlj+OgFZrURLYyzljpgP3EZYIYSLBDID6328qNmjfVX2VH4IHiDHMdVg
         ROI4J46S64WfxwgFofxjcEnnDEaZAy3CkWMnhVtvmn7moF/Laq/3+MMqwMX7j7HoZd2b
         YDrmuNyua90xwQX/UxjbfM9etutoVbvxP6xeN0I711ANdJWwzoV7q9nnhSqPZ3rExPjL
         XjKNvquz4GFoxa3A9fj4SKZPzhdY3xe/kKgeqBTDHZVN9t0jij8VQhvBi3Iy7NpynoL3
         LYdg0uh3XS6ZWBOAp4lyG06iBas7Z9oI3nhFAyelazgi9lUQ0hkA9aqAzjXpEOVmozm6
         Ua6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780684612; x=1781289412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P13RElyEY77N682sCtZ4HPH2+wcRcMGtUhEt/2n1PrE=;
        b=Mr+MvPGk/oni7cunDNLoPgVDJV2SxexSzbhc1mzFoGjSIKEgw1vBZK960qVYSzdzOq
         jTe1o2wvcoIiKYQm30Las/qRupoJQE0cwJgO2HwKPzhp76XuUA3vQ1qfRScU1TNQFf9v
         XDhS6gdFMWTWEEekS9RxcsG6eKZCjyLcsknIDbVF3OQUE76v6VUbG8b26hP89TIXcGcr
         +TMBPCrTQxkZHm7E/Q5GVf3uB8QmS18XGy0ate4uH8gofmDH5LDWokJugX6nns7J5Drp
         iAsAvcgFyZmhp0Ntjk7JxEnYZBDRpGOzPvdyZd8GySSgc2v5aqEbWXsbhVMjZ4LkbvV7
         cSvg==
X-Forwarded-Encrypted: i=1; AFNElJ/nGGt4Dqnt7qVAEJSJv0mxKTe2YEaO8go3vQSvPXa12tKpCgzMFms5zE3d1uiV5OXWmIPI9oW5WzMVA4y6@vger.kernel.org
X-Gm-Message-State: AOJu0YzBhvaVRdL/4Tf2zT3APt3e+08etyuX/DJplxhCljYpbHFhRR54
	3FIk03v59L8jWJvWYFj1961kiwjzz0Uj49YwuArO2cGMsAa64HXCr8BGbaSJYcMdoh5OyJaOORA
	VBAuKBirb
X-Gm-Gg: Acq92OEradK+6hoMgk/CfxqYUs+OaWJ6JFEWfZgO5IHwn5nOTDz6JSdSFq3mxU6755I
	RQJa1934/YTRSuASbEk/mG4ELN9WX+azLXaR1aEU9y49sezgtElXM6ef05DTYY34NU9t8bsDzTE
	pJ9DnQiAmjFF1+vlvozQR590PfMeCKT3Nf+91wRJVDc4A7itaAZHON+/1ggTtFYWUIkXeYcJFGs
	d42GZO2rRF1fr+ViY1e1jsUa/EOIKPVl1SE+e5tCUsnw3KNlBH0RfsV3IwPD4aLmT2rvc5wuUYK
	XA3vM/peWrdwliq+p23GagJ7t3LFgB7ESOIeWTgZq1EUPl2QOr3W9Qclwx4E9C/5BuhyHF7D89k
	wBCrBXc7t6ENyAQZcRPqUio8pmj0lRqczQdahOl/QRPLUi2+z2SAwOSK/5lSqSgILyzdxLoLRWd
	tpmk5u4seB6xPNmhZV2f59u9v0MtgRFxmopdAZXi7VZ2oJ/L+fTjj0mAsB2TcU+tq5hxD8jeNe1
	qq8mw==
X-Received: by 2002:a17:902:e5d2:b0:2c0:b1b0:376e with SMTP id d9443c01a7336-2c1eb742daamr2207405ad.8.1780684611222;
        Fri, 05 Jun 2026 11:36:51 -0700 (PDT)
Received: from google.com (171.46.125.34.bc.googleusercontent.com. [34.125.46.171])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0b315esm8340917a12.26.2026.06.05.11.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 11:36:50 -0700 (PDT)
Date: Fri, 5 Jun 2026 18:36:46 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Michal Gorlas <michal.gorlas@9elements.com>,
	Kees Cook <kees@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH 0/2] module: restrict module auto-loading to privileged
 users
Message-ID: <20260605183646.GC2939956@google.com>
References: <20260515-autoload_restrict-v1-0-40b7c03ddd04@9elements.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515-autoload_restrict-v1-0-40b7c03ddd04@9elements.com>

On Fri, May 15, 2026 at 07:20:18PM +0200, Michal Gorlas wrote:
> Add option to restrict the module auto-loading to CAP_SYS_ADMIN.
> This is heavily inspired by CONFIG_GRKERNSEC_MODHARDEN of the latest
> available Grsecurity patches [1]. Instead of checking whether the
> callers' UID is 0, check whether the calling process has CAP_SYS_ADMIN.
> The reasoning here is that many modules are autoloaded by systemd
> services which are running as privileged users, but do not have UID 0.
> While systemd-udevd runs as root, systemd-network (which often
> auto-loads a module) for example runs as system user (UID range 6 to
> 999).
> 
> When enabled, reduces attack surface where unprivileged users can trigger
> vulnerable module to be auto-loaded, to then exploit it. Recent LPEs
> (CopyFail [3], DirtyFrag [4]) for example, would have been mitigated
> with this option enabled as long as the vulnerable modules are not built-in
> (or already loaded at the point of running the exploit). 

This sounds potentially useful as an optional feature. Kees, you've
looked at grsec features in the past, do you have any thoughts about
this?

Sami
