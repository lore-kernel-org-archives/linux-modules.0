Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8282C1FDFAF
	for <linux-modules@vger.kernel.org>; Tue, 12 Nov 2024 00:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731372541; cv=none; b=PvxMU3aTks+K5czF7LGJrcIdpxI9mNi6f15JmCuRfgMtwPmf3vM47hN6xQSUWdI/dNXTN99fVpIPtjmG30oDheXHnhehkZvM+MgNBUwcnrzqg4yRMk+5ogZ9Buk20yfb5amGSiQApRVldZG0dsBUzyT6whLMepS4KEpmQDmj+0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731372541; c=relaxed/simple;
	bh=kYrzIGpGTAdZ+l/frIKwRSqMzvZbvhwJEEu4sv0ER6U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iOJX8JhoTxoEpdqBToZGut0uuaYgxoqhveObe68nzGV4Ah8T2wS6iGEabi1ULX1O0Fg4kNkfwoKTsa+DbX/atm49sBjsi39nAf2J5dSKgEJTin31SvkrAXaQwjyHYiRbJizWscwVirXigD/xjmi8XHZfs83PG6GGp4ucRhNvxZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EcMYPIg+; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EcMYPIg+"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7f45155af9eso1781394a12.0
        for <linux-modules@vger.kernel.org>; Mon, 11 Nov 2024 16:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731372540; x=1731977340; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V3d51sumdx2ObGqeplCpCcwVtIOlKxVMh1GOKKAkQVA=;
        b=EcMYPIg+xSc7sZ97E2Y6WDQ0v/J+eSWuiVvDncScmx5/fqlTieQo+ayOjaCIstZHpL
         vLiDy4IzwCmaCJhKlIqvtdMPs2c3Rq+JCmkB0VEz0y/k9Ed+2D1jqjzCXHNkTAnWfOh+
         oovIV9E6raPuREhYznWvVsmzS8v6dN/F7ZID6aZYWafq9I54N52xSZLTR1VQnKM9JERd
         MSG2vPO/c4gxyBPd9kgrEvtAKoRkotO2W4g+/KN3Nh5ktkrak5C207ayp2bxqVgtvhIF
         4WiDAfPULUycGJOIniCX+n+yerKMVea8HCi8JNNPb8Ie0kB5Vc4Atls1kvNKpROzaxcN
         HFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731372540; x=1731977340;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V3d51sumdx2ObGqeplCpCcwVtIOlKxVMh1GOKKAkQVA=;
        b=fMGazM6CRvyt3o2hteEWY5LK5Tf9Oh6FNOOCbY25eVo/p7tOUNm1fKmssI9THo3kQu
         H6RESW1Ytyf2v3fWjsrsE5MrDpNlOQgL0MIBYQ1x2zdPuT588wc2hGusehG55dPcXR8+
         VFOAQSTnWICriEQigxYGx1j8xipHEmku5wLE79+zsAL1jqDiMXrbY1Q7EvU9xNqvpjZ0
         lTZoUJHD5l9/hgyqsMuKsY5D42G40jWYmD16qZUvkaUGe6h1Y2TttMXPOYDaFhcb2Pay
         svmDyx3lGCBIN0rYXi2NAKngUwbsDP0P79xm+Vf8YHm6XqM/3ijaOLwmNNxdU3eO8ANY
         uM/A==
X-Forwarded-Encrypted: i=1; AJvYcCV1a93NdC79KSqbcaldxVdVVZEk8yqK5e9OyH8MCx36GIEqE+EFswrezpIcWfNTXiaBCdwGUpkIQkrjrO5d@vger.kernel.org
X-Gm-Message-State: AOJu0YzF8cfuCI8fUCRmLQ76hbSmRSV2MbOHlNaNJDvCCe90TiXo/gaw
	tVWaQtCsFYCzsTo5mJuwLX2C6dLWlCiWwDlcfXRp9agY95ts0obdR6R8aVZpF6zSiZM8PXVSiUw
	NWw==
X-Google-Smtp-Source: AGHT+IHlyWiwcxXqbhz1fA8zTtz9hHIbjIUyo1Hj8c0N93O+44mC0qg7F+KmIsWLl9LBY634Ti3J8Ix3Z6M=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a63:943:0:b0:6d4:4eea:bd22 with SMTP id
 41be03b00d2f7-7f430aa4f08mr49656a12.4.1731372539660; Mon, 11 Nov 2024
 16:48:59 -0800 (PST)
Date: Mon, 11 Nov 2024 16:48:58 -0800
In-Reply-To: <20241111105430.575636482@infradead.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241111105430.575636482@infradead.org>
Message-ID: <ZzKl-ldUQD9ldjWR@google.com>
Subject: Re: [RFC][PATCH 0/8] module: Strict per-modname namespaces
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mcgrof@kernel.org, x86@kernel.org, hpa@zytor.com, petr.pavlu@suse.com, 
	samitolvanen@google.com, da.gomez@samsung.com, masahiroy@kernel.org, 
	nathan@kernel.org, nicolas@fjasle.eu, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	hch@infradead.org, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Nov 11, 2024, Peter Zijlstra wrote:
> Hi!
> 
> Implement a means for exports to be available only to an explicit list of named
> modules. By explicitly limiting the usage of certain exports, the abuse
> potential/risk is greatly reduced.
> 
> The first three 'patches' clean up the existing export namespace code along the
> same lines of 33def8498fdd ("treewide: Convert macro and uses of __section(foo)
> to __section("foo")") and for the same reason, it is not desired for the
> namespace argument to be a macro expansion itself.
> 
> In fact, the second patch is really only a script, because sending the output
> to the list is a giant waste of bandwidth. Whoever eventually commits this to a
> git tree should squash these first three patches.
> 
> The remainder of the patches introduce the special "MODULE_<modname-list>"
> namespace, which shall be forbidden from being explicitly imported. A module
> that matches the simple modname-list will get an implicit import.
> 
> Lightly tested with something like:
> 
> git grep -l EXPORT_SYMBOL arch/x86/kvm/ | while read file;
> do
>   sed -i -e 's/EXPORT_SYMBOL_GPL(\(.[^)]*\))/EXPORT_SYMBOL_GPL_FOR(\1, "kvm,kvm-intel,kvm-amd")/g' $file;
> done

Heh, darn modules.  This will compile just fine, but if the module contains a
dash, loading the module will fail because scripts/Makefile.lib replaces the dash
with an underscore the build name.  E.g. "kvm-intel" at compile time generates
kvm-intel.ko, but the actual name of the module as seen by the kernel is kvm_intel.

--
# These flags are needed for modversions and compiling, so we define them here
# $(modname_flags) defines KBUILD_MODNAME as the name of the module it will
# end up in (or would, if it gets compiled in)
name-fix-token = $(subst $(comma),_,$(subst -,_,$1))  <====================
name-fix = $(call stringify,$(call name-fix-token,$1))
basename_flags = -DKBUILD_BASENAME=$(call name-fix,$(basetarget))
modname_flags  = -DKBUILD_MODNAME=$(call name-fix,$(modname)) \
		 -D__KBUILD_MODNAME=kmod_$(call name-fix-token,$(modname))
modfile_flags  = -DKBUILD_MODFILE=$(call stringify,$(modfile))
--
