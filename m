Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF27165F16
	for <linux-modules@vger.kernel.org>; Sun, 23 Aug 2026 16:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787503624; cv=none; b=oIojTAOLdpfSzUp89dq6W0+V78GG6lTgLVUdXg6309BEAZt7nSAemGyTplOgozO/6daKL7ritrRkp7CSRbK7/ReiQFCJNIF8j602qgQFHsim5tRkA+KDjPIjreF0jqNkSPmjd8oAUURlAW9cbauKQ0dNNODZ2UXbaDeXwhyqXbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787503624; c=relaxed/simple;
	bh=4nJtT0eByBpmmlqV8mf77eY46G8vbRGQvMMyJIfFa2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2eEnB03nfuro4utSVEZc02QPRZZPacWN+JqgKmb/EGJX85TUgfRDDb2W2/sBpXcQypaF+VnzFN1D35x/fuWM7NBuqF5P28S/xRAc2s9bgdjlO2cF2vk7vyO4cLMMavqwEXwxlIs7HMEy1Nt5YalkN0wuONdgaR+f7j4YVMRkwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ctcOsr2z; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ctcOsr2z"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47fde295992so1766863f8f.0
        for <linux-modules@vger.kernel.org>; Sun, 23 Aug 2026 09:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787503621; x=1788108421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/ZF6HUGQYWvBUACVOKONbBRQQpsYWeEt/fKmrPzcNd4=;
        b=ctcOsr2z/R+JRBIwogX2QZBRCa1XQokGcjKMYqrvZwX4qOGvf8zUPEC+ZQ1UpqcSgN
         VpgBAZjep0QM8rxzl3kpCWVuHD7aD3o5OpGvbL7vg3MkH3qih9ef8UkI2twA1DG3SyCU
         JeoydYU2UM+bpcvzkBKPX0QYB7A40IOWXv2ifGU9kidkcOhPkqARTJQdIMfKc/HIx7Ri
         q4lFdiBZERWNWhR+FJJyBjZColY5s0j8hqe4Wd34sRkH68KyNkpxuSJjforgtZvrust/
         Q5E6z2TUauD5qi37KGEsSI8V1G5wuBX3UzxoQ4gFA/fxAoo/NTqOoP5IAFFV6WPctNXc
         Ffew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787503621; x=1788108421;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/ZF6HUGQYWvBUACVOKONbBRQQpsYWeEt/fKmrPzcNd4=;
        b=U9Li33keHPRHshaft1qAOoPRsA8XTeWO0W9ypLnAgIahA73FkHC+fpnhmaYPZqXeE5
         b/dxtlp7rZ3Iq1Wvp697HjfD19tpnr1PAsRTAv133m4JVVkaXQqShxPTZlvN8NzqfGo1
         Q9BF8ix/BrgCMoRl+r2lKvJlJKJL7ztkWBdM2kJ6C+cm85Ak+6Op/oBRWZOn2i68jAAB
         PmsYCCSLMeDscZm0xw2VJ+HFNmV2CodP4JVHhlCV7SS8tm56KPjYNThFjH00niVuXfi4
         odua7NuoIXjC5TSvfORwMlYw3R12YGjQAV6M5CRWhk36YFN6zzkeV84jgUnbuemwLIEw
         jp5w==
X-Forwarded-Encrypted: i=1; AHgh+RpUqY0uBDHUiGkso4p98Ff0uNdw3it7alWv/u5hw8u425tZgtN8oGgL3VfQuEnfEm7s2MJ03JmoFvJrjddG@vger.kernel.org
X-Gm-Message-State: AFuF++mk+cE1UctFNMLMdbtCYOzmZ0gAXw3cc0yGb+6y2slFTEGNygYx
	7TDASP76B/tC7OEylZuofqh0TLsJfhc+VuTiI0rxa8fIR7RQqmi/EaUeYATCf2s4WQ==
X-Gm-Gg: AR+sD102rVY0txnbdVBHqAV8Qvi8C9A5t5pIWm3BVYmyvMBMbTcejkxBzEZiBeLEn3X
	2viG4Mbg336KZ1LOyuAtSaBu8M3LLhH1fSHPxoi1OZtoimtOciczmcCr9VL53Ja6UfePFC0T5Wj
	MXgDRamlt98govJKPPTuDO9R8YIGnx+JZmGmcYiM0NY0ycJ3RUK56PyarRI6Q9BoGUTxQJp7MYV
	hG2yQxAWWi4ejnWBMJyHQfhwtnCucSD94AFko7+dDsqOC1clewhOq+OZz82A5yVXxrVfplNLBjo
	s9YVJGjUza4VCO021J2Lna9pxgu3HxQ36rXeGvFhsL/xPpt9AgoHS1jEJ3gysXihQjzh12BAfQ0
	kEuDyoG+iI/HnXmIReJcCDvGskFCrfhpXV8icUDzYgCSx+hHwOj6qakBxaiEdU9Gaxy6dOeALUX
	gyinTrwKXIPK7e5mEYZGrazVzob7VFBpgp+u+5COVrGjX6QcnAcaIqlstGlD7d90gklX/dGK6mM
	xshteZraZFPSkbOQNFzFVlY/g==
X-Received: by 2002:a05:6000:3104:b0:47f:8554:a341 with SMTP id ffacd0b85a97d-482b784c4bbmr35989706f8f.13.1787503620630;
        Sun, 23 Aug 2026 09:47:00 -0700 (PDT)
Received: from google.com (78.207.190.35.bc.googleusercontent.com. [35.190.207.78])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482c9bfd2bbsm5538099f8f.18.2026.08.23.09.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 09:46:58 -0700 (PDT)
Date: Sun, 23 Aug 2026 16:46:55 +0000
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
Subject: Re: [RFC PATCH 6/9] arm64: Enable the execmem ROX cache for module
 text
Message-ID: <aosj_1LChfLM8xaz@google.com>
References: <20260822135323.795946-11-ardb+git@google.com>
 <20260822135323.795946-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260822135323.795946-17-ardb+git@google.com>

On Sat, Aug 22, 2026 at 03:53:28PM +0200, Ard Biesheuvel wrote:
>From: Ard Biesheuvel <ardb@kernel.org>
>
>Wire up the existing support for the execmem ROX cache on arm64, so that
>it will be used for module .text and .init.text regions. This will be
>relied upon by a subsequent patch in order to allocate those regions
>from a single chunk of memory.
>

Until Mike lands his changes [1] on set_direct_map, enabling ROX_CACHE on  
ARM64 would cause a permission fault when the same part of the direct map is
used again (the RO flag is not properly stripped off after an execmem cache
clean).                                                                    
                                                                            
[1]: https://lore.kernel.org/all/20260823-execmem-set-vm-perms-v0-2-v2-0-b013a37d84b3@kernel.org/
                                                                            
Best regards,                                                              
Adrian  
