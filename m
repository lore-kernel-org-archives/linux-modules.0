Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E786D34B66F
	for <linux-modules@vger.kernel.org>; Sun, 23 Aug 2026 16:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787503976; cv=none; b=lExNmc0wSKwnrXAmH3epNQ3IHfQ8GXdSDAk1yhUs88Z7kWCfdTjnqf+mXUEQX4xKQqGEY6OeSW/GtK1eg0g1k/ryp2iyMBz64FnrOWYm1vSArgU+PzANZvqqqnDmdkYxwy7I4S1f/Z0Q/c4tOVSkEvIwvOqEjDtwhZptmICnY4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787503976; c=relaxed/simple;
	bh=hWjQifge1RAK6z478R1PFnRWX2lnMwsgDiVDTSmBsn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sygYuqxjuGfJ/zFFug52/j8k/jZEN/b69+ZtvhFm/e7njUYBMJBXSkzrZwthLgyeJQ4+CyPcbiQvAUqX7Oz4dZKmqyk6JsndPVchaMAu0I7mF6oFI7z8lweAobykNPFhwvGMooU23v8FVQD1OJzm+sXktxF6V8Y5RsiUZFQSHF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GSR/krCB; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GSR/krCB"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-499b0eefa61so15065325e9.2
        for <linux-modules@vger.kernel.org>; Sun, 23 Aug 2026 09:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787503972; x=1788108772; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QjRcKycCgEIdRjuuH2tPItX4wlK7ZDllY3I75Ar7NjE=;
        b=GSR/krCBETjHDRHfIT+yJupj3qM6I2DiEfRPvo0ckTQ7BwoR7fYMdY/yytfRR8kufQ
         fVf2aFwMqflvHWsUNWfWyrzeF/7LICRSVmzT7H0xiA+zI9f02Eb1Wco3bdatGBSpZqIL
         gfQugnMPnF6zGU8SrmrBJM8DgbVUdDxu1jNaaIBm+j6/nFciAPFAVSQcLSyvPdtBfMob
         8U2YUVf8Ib6S28kOlvl3YDp+P+msDCi6ZngCAJ1sNC8KQf811M8TJluLgzeZCwhnFPyz
         qEG6GyFh30l7hiUaYSQlwTph8cagFfArmxfYNA16Q9qgurPz6bb9UReRJNCx/4hiiddF
         fhXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787503972; x=1788108772;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QjRcKycCgEIdRjuuH2tPItX4wlK7ZDllY3I75Ar7NjE=;
        b=CNakTUT3sdqsiu0FL7o3CMjqr+XfVzyiSos0AWfGcVmfNLcelj8K2sGeS+hNVZPaJM
         PDwAH43nb425iNy065+cG34xj+sABBRSSLy1YSExdmHUaUeuVrLQqPnUP0qSHI5TOGxf
         Dm5rkKS0UYLYNGs3xTf+AVOO06LPC3WJaeDh69c4wRruon03rfUqwVOx8pYXkuk7Dix4
         bHmQgxWTsCiKbna7AcKX4Kmk7OtQGW/3MVguWC/wktSeCG5yhaznsHBG4Uq3ZUejXueV
         uBB5VSPohgvbi0lRMuI0R2lz8YaNw1nN6bUuNYslEH+D2mif7dKykHk1OkQGp4ess2E0
         xK0w==
X-Forwarded-Encrypted: i=1; AHgh+RosHBCEFhrkODxqWN/NeWVQZPfzwL6DmcAFJG6dHKsEp/nqP4ZoCMOYtwxQBXE2YpE33HiGAv3IFLFCYesa@vger.kernel.org
X-Gm-Message-State: AFuF++nlnizuhWteqFHMmQ9gtFYdY0D6zaE644Wj2cT7IiiUAMjss4wb
	xz/7n4V83A1gs1xYLcE2L9WxxPMjYccRAbF6flgc1oWyDFBwnHlCqsG8iksA9wrL2A==
X-Gm-Gg: AR+sD112bHkO6kSdI7bE8VE3FVLwbKAOarzCS279/NPiLP189hN9D9S4AfQI/HSL96g
	XTN0EJ2LznrczurR2LTQdh3qDJzvn5Ih86adZ2DPOZwfqgcd5lf34vTx7D40eF+y5HmxSJ7uhA5
	IHOgf/CfFaVNA+YbNTQXbnN83SRsdkw6vVctJGvBsoQ3/fh6S4G4eTv3veIcIQ+/5xin7Afej0x
	FpW4i7GNF/IHf7JQFTijiedLh3tvKk+nJO8a+/ZaKQ+6Q4lggI9BzeHMwB/u8tSFOL2s8HZxqn1
	mh2nOip/YmAIQVEW/GpCGOs620LSYpfLn33YRTytNQiQIsBPV1U7aJN+jB+SuUiQKyWsUoTKCYY
	N6P+2Mh24uMAjyMSD//r+/h1J/4l9oMTvyLCIDklz5ZsKFrtrG5X8VyGC6CdExUy/foaYGOrN3U
	Rybl2N+rJQtCVpat8btsxUxjDT25FahCPJb/AmhQoFukvWJLL5DQSrqdconoJpIXi1llQJ7qXN7
	80L9tOMGoZDvdvnZ+r+J83NwClNmYywyK9vn1waPAI56HXU
X-Received: by 2002:a05:600c:34c6:b0:499:5f7a:7ea2 with SMTP id 5b1f17b1804b1-499c19cbbd7mr122720055e9.12.1787503971299;
        Sun, 23 Aug 2026 09:52:51 -0700 (PDT)
Received: from google.com (78.207.190.35.bc.googleusercontent.com. [35.190.207.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499c33098besm53780005e9.0.2026.08.23.09.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 09:52:50 -0700 (PDT)
Date: Sun, 23 Aug 2026 16:52:47 +0000
From: Adrian =?utf-8?Q?Barna=C5=9B?= <abarnas@google.com>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org
Subject: Re: [RFC PATCH 5/9] arm64: mm: Permit permissions changes on huge
 vmappings
Message-ID: <aoslX8cDCR647ebE@google.com>
References: <20260822135323.795946-11-ardb+git@google.com>
 <20260822135323.795946-16-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260822135323.795946-16-ardb+git@google.com>

Hi Ard

On Sat, Aug 22, 2026 at 03:53:27PM +0200, Ard Biesheuvel wrote:
>From: Ard Biesheuvel <ardb@kernel.org>
>
>Allow permission changes on huge vmappings in cases where no splitting
>is needed (i.e., the region is aligned sufficiently), or when the system
>has support for splitting live mappings.
>
>Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>---
> arch/arm64/mm/pageattr.c | 13 ++++++++++---
> 1 file changed, 10 insertions(+), 3 deletions(-)
>
>diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
>index bbe98ac9ad8c..20ff9cb273c1 100644
>--- a/arch/arm64/mm/pageattr.c
>+++ b/arch/arm64/mm/pageattr.c
>@@ -169,8 +169,6 @@ static int change_memory_common(unsigned long addr, int numpages,
> 	 * we are operating on does not result in such splitting.
> 	 *
> 	 * Let's restrict ourselves to mappings created by vmalloc (or vmap).
>-	 * Disallow VM_ALLOW_HUGE_VMAP mappings to guarantee that only page
>-	 * mappings are updated and splitting is never needed.
> 	 *
> 	 * So check whether the [addr, addr + size) interval is entirely
> 	 * covered by precisely one VM area that has the VM_ALLOC flag set.
>@@ -179,7 +177,16 @@ static int change_memory_common(unsigned long addr, int numpages,
> 	if (!area ||
> 	    ((unsigned long)kasan_reset_tag((void *)end) >
> 	     (unsigned long)kasan_reset_tag(area->addr) + area->size) ||
>-	    ((area->flags & (VM_ALLOC | VM_ALLOW_HUGE_VMAP)) != VM_ALLOC))
>+	    !(area->flags & VM_ALLOC))
>+               return -EINVAL;
>+
>+	/*
>+	 * Disallow VM_ALLOW_HUGE_VMAP mappings unless the region is PMD
>+	 * aligned, or splitting live huge mappings is supported.
>+	 */
>+	if ((area->flags & VM_ALLOW_HUGE_VMAP) &&
>+	   ((start % PMD_SIZE) || (size % PMD_SIZE)) &&

If I understand the intention here correctly, I don't think it is valid. Even   
if it is PMD-sized and PMD-aligned, it would still cause a split because  
the loop below is not using page order, but performs attribute changes 
page by page.                                                                     
                                                                             
Best regards,                                                               
Adrian
