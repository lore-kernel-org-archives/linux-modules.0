Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01923DCD95
	for <linux-modules@vger.kernel.org>; Fri, 14 Aug 2026 20:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786740262; cv=pass; b=M4QLxxDDfIpTyAOpsXyqR0K7afIISPMN22WOo5vUtETMA/kfaIV9XIOQCDCoaVwZu/DPZjf5tZNSDjxQX2KjtWjbU6/UdcxMNGDeAaMqpIhgM4wbluLO6k8mRf/f4G0KHqE7auV61xw99SylUShrijCi3D+zvqr47Gg+vowEuk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786740262; c=relaxed/simple;
	bh=Yef0+XlIt5CkGyFDHekUoQrBKiNSnjOiMr6bDpxcEAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZkLjsz/MWEIEhJ5R6pcQTfzDtledAjAgVfBk2faGxuAQF/i9/ylytTbDSmfxNB+mHILm+Si+OnR25+V/kOoPkOjVAbKp5kCR03Wvwi8+yap3W+pKkMKzqRPz26fbGqLtqiym7KxaQaL9N2YpW/kKOxKC4yitL3oFdPTr1uf9u+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eNr582kv; arc=pass smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eNr582kv"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-754ac74c495so442073137.0
        for <linux-modules@vger.kernel.org>; Fri, 14 Aug 2026 13:44:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786740260; cv=none;
        d=google.com; s=arc-20260327;
        b=Ul2W4M41QjjlQ/PG4DU0bjFJixK49WMNTSvoWokCUcYMJD+p4pNrTnVmBJN3zp4+J6
         XBE7VmEgLL+ojVdJ+mXa7o6/+/553rexEFTMiNV/C2KAiK/L/lLFXd56V8pKqO5um4Mr
         euPzxlb+rMQnjSVKdgMrNdJ9d5a54IB/DjUhuRD9uAVSr/9mNsTIt2bLDXsT9uuCIXvq
         oY7XkTLzdkLnvlMnjPUbm4q2HUqdU2npoGREH0Ne6ceVf7EbX6dD0wO31qrLoSg/r6d+
         vqWnQwp0CJgxD3wSTmxf1Kjjl5YOjrANVnNhZ3aCVUX12/NOC39B7iS4gXOwDuf3Jzd+
         0KWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GYGwalcvjkjv/vzHq/Wh7lCLdSqyXSnP87QCybk111Q=;
        fh=3hM6gyRql63JQnupwiqPejuICghiafiXncW77fVGb1g=;
        b=ll336VYLtaGXbjPb1YNwPeDUFEzp7wsi4BavkfCtJltFfwaWEVdMtjGqmuI/vHnM6Z
         lAS+CItILTqShY+Xmmgamt7Gy4UOcgFY4o78KKcRJxt6td1IkIlHtVGpf6PAWq7EFTph
         131rmcEyTVQtNGAhYDegSBGktqjxA66mno7B+Yxn1sUYATL5ngWPWpIKtchvaf5FfO+h
         xttLPosYCaV+cG1jxoUtlE9rF7r3qGhA0EcFbld2EyxmOZSemoqsER0+199Lo03ncWBR
         fDR9SOXP8w32SYeazWRvQjEpqd/z/O/Kva8Q0KvrTX+0aI50TlQZoFU+icNXveN7sw6e
         9RRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786740260; x=1787345060; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GYGwalcvjkjv/vzHq/Wh7lCLdSqyXSnP87QCybk111Q=;
        b=eNr582kvWnLdBPVqBuLK4CuituDSaYuO7aR+Fg4aUogm04XgO7g+CktP3Q0m4yklCR
         TCIlf7yhwKgUuLGdDcFdeedymXyRVIEFzLP18B8jvwz6wUQv8nKi1HyIWi0zRQw12eW3
         BpjjjyoECEuQX5IByb/44ERJNUG5wPkJC0tc8YxO/FXdmsoT+BpmzXSiqJwVhKV/mB14
         7jhuvQ3LhPCaSGVxaLGo8NMF69CSMTHnXq9L9g/WhZ2oBXUCw8BM3iHqHBxIdl3Ii8fC
         i8jh/S6KmyveE9gqZmSMz5BefUeAPcFxz2NEm1HCTfvS0EUbGzOFRt0UCA+fZ/S4qV6X
         zoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786740260; x=1787345060;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GYGwalcvjkjv/vzHq/Wh7lCLdSqyXSnP87QCybk111Q=;
        b=n7JInrGyA9ps9/VrcteUXYnd5ANP+5I5yXa+5F8BxVcq2u9a6QgTTjI3/HKUwljnzi
         PFmlrL9LFRUXmkPfkYwzFVCsuLg1tEn/DnEdEAcCXKL+WUtu8iBEsNKvXZ7yyjIxxm+m
         4HO+fAS+VN6CAmBhwM3abUNaJdX1K5zaG3w704elKroIZtg4hHkABX3AFVdWjIg2NLhb
         HMMvRmFOb3YlHOIZTTsAUSM8M3J7/Blu5lby4dl9lv30b4b0UY56WoqAKVFtmFL0ttSG
         GlnxbPXnB5D23wQwqTqGmyEPy717fy9J558ID4m2CLNT+WZT5BTYxoKRh/o44uiG6VSr
         B4Cg==
X-Forwarded-Encrypted: i=1; AHgh+RoIaqnGjrLgUDk9SoYQeCiJISPNvqLYQ45sPSX4uzUneW2ibfvguxSEWx+rENzPsLDfSM8iTds2su6OMSjr@vger.kernel.org
X-Gm-Message-State: AOJu0Ywve0KdON2bZa62UGfULH55IWYSc4BzlFh8Oa+L2lV7jenellSi
	AV8kcZl01/HYbNZ3H5r67W9sBBX4rbeJ/Wyq+PclrVr6qRsmUIKgpU8lD1o2j6SJGXk7xUycEVq
	9fFN9kaCG523cqXkGZTv0izT0SMmlKc6IM1F1vyFt
X-Gm-Gg: AR+sD11ayh1QYCq6Syd3YKoVMcI1Iykn3nqF01GdOUD91DuNlRYoFQ6Hr9BVvgxGLYh
	XJ03d9UdjrA8pWOAewJSQqPhARmGG9IHtYI8OaDC03Hz4YCzw5/njb6k9oNODYVY69yN4b4+9QY
	nM89bvVCAu/rVez9V8Gy+6S8WAHFirX6pqHBz3uCJxFl49oP7ZSV3xlwD9bzM9TbqJ+dEmUZVAN
	C3Y1z0Wm05gbekrrQFibXCPgg+rV3usw7JIVpeAjbYLDkV806oPGgetSgQXoUV+OXST2HCffO2c
	VtV/ZCsILUxBPvdivxNvtMAF+RqABZ9kY9pF+qJBcHyD
X-Received: by 2002:a05:6102:548b:b0:75f:e517:ec96 with SMTP id
 ada2fe7eead31-76f27377fe3mr1344823137.0.1786740259079; Fri, 14 Aug 2026
 13:44:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785727106.git.jpoimboe@kernel.org> <9548393f4d89ec3b498f4f69aa6ef6b9bb7150fe.1785727106.git.jpoimboe@kernel.org>
 <anyufyGq2d-7AC_H@google.com> <anzW_H5OlQ-MqWjf@jpoimboe>
In-Reply-To: <anzW_H5OlQ-MqWjf@jpoimboe>
From: Dylan Hatch <dylanbhatch@google.com>
Date: Fri, 14 Aug 2026 13:44:07 -0700
X-Gm-Features: AcwNN1Ws2u7TqlGkWkPnRDhb4Ze0atWVAAtFKe83ByDo08JtuB09SoN8yeYeXKU
Message-ID: <CADBMgpyY6R_YmEqhZSw=88-Bfkv9=s-N-x1siE1uPAgH_fTURw@mail.gmail.com>
Subject: Re: [PATCH 03/14] objtool/klp: Fix false module dependencies caused
 by dead relocs
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Song Liu <song@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	linux-modules@vger.kernel.org, Ben Procknow <bprockno@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Josh,

On Wed, Aug 12, 2026 at 1:27=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> On Wed, Aug 12, 2026 at 10:33:51AM -0700, Sean Christopherson wrote:
> > E.g. if (not-so-hypothetically) one were to try to livepatch
> > nested_vmx_enter_non_root_mode(), how would livepatch.ko get at things =
like
> > kvm_service_local_tlb_flush_requests() and kvm_spurious_fault() without=
 also
> > creating copies of those functions?  Wouldn't the kernel need something=
 like the
> > below to exempt livepatch modules from the restriction?
>
> Indeed, though we approached it from the tooling side, see this (not yet
> merged) patched:
>
>   https://lore.kernel.org/fe5a00818e06ec613344d41d5944de054fcd8832.178613=
8493.git.jpoimboe@kernel.org

In the case where KVM is built as a module, a livepatch to
nested_vmx_enter_non_root_mode() doesn't seem to work because
livepatch doesn't allow KLP relocs for vmlinux symbols when they're in
a patch function originating in a module. I was able to recreate this
failure with a simple module/livepatch combo:

https://github.com/dylanbhatch/linux/tree/mod-ns-lp

Is there a way to work around this issue in the .patch source itself,
or some other way to allow these relocs?

I'll also send a reply to your V3 patch with some more details on my findin=
gs.

Thanks,
Dylan
