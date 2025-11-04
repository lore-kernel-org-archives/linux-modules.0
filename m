Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA10A1F37D3
	for <linux-modules@vger.kernel.org>; Tue,  4 Nov 2025 03:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762225519; cv=none; b=ETgeDKWkQCRrEKC9PkCR7Sdr6yw5kjVkzkGBo+nzk9VBXHxcDC5KWPbPlKlsuOLgP3MZKWFFAdIcgsnvyGyaNJAe0UNOCmYunHM3Yx5Cjxcj0pbEcGs6gEox6vxmNer4JqSsyXuhlycmumRk6ZhEXNB7n0253CM3mVDU+uZfdls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762225519; c=relaxed/simple;
	bh=zfM81kXC6sJ/IE4hirAILuUoNxe19cJF3g0TTlIFdkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqlSmf24EFHEnWuWBBwHDQpyJ44INyKCqZPyKIaqj+IDqb9WzNdsyw2OuopYkK3K1lQvKndCyxXMPLI9cN8IMFo6bVlkxm2+sVlOIlpBuzMx0TajgeZALiiQfx9hLJ+ahZ75UfkeBDxXAFmiqQCrwf5jcF9s61Ogj14k8UTqSpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iTCMlU9l; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jJT7ALQW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iTCMlU9l";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJT7ALQW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762225516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jkuPUHUimKy1GkV2j4jms8ezPzMfA+mYVSVtk+5pXSk=;
	b=iTCMlU9lqRwLT25rLdekyJ8U0pjihFsd8oHlqi5mEwr41aDC4ejUwX7JueIH7CfYrICRhB
	wKVbIBasR3khVE0K4T0TOQIR6aONrT0yZKftCLUXUXI0y2aMase0SjuZr117/ZHrAnQF6V
	1AcSs/ygBlYoHQ+Qeh4l4U+JgnKJMzM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-dC_6nn3yNAChUY0BqfxHTQ-1; Mon, 03 Nov 2025 22:05:15 -0500
X-MC-Unique: dC_6nn3yNAChUY0BqfxHTQ-1
X-Mimecast-MFC-AGG-ID: dC_6nn3yNAChUY0BqfxHTQ_1762225514
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32eb18b5500so9104321a91.2
        for <linux-modules@vger.kernel.org>; Mon, 03 Nov 2025 19:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762225514; x=1762830314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jkuPUHUimKy1GkV2j4jms8ezPzMfA+mYVSVtk+5pXSk=;
        b=jJT7ALQWLO+u3bXprk6DCUx6bcvFCZJFjR4prwnROBSIfpKQINm9naRTF8YheqE0GW
         LxhR1KEsKaRCFek/3T4+7qxF2Kz/thjaWX16llYM3wcXlXFLoz5jFU5/bPvotjHtXQf7
         yy+p8D+2BOQNPZy8kEou0vUBTYC99UzL3fIUNGpgK88p+A7Ik61umEHFKFpJ0OqrIbJs
         Qgv43SmgQ6MNmwbfzKMCaK4WcdkHeNawsGXFVYCz9WQ73rWkXpW0mEjOQ26c3EEvGDlq
         AAiKEqWVmCiDCmbV3an3zHX2Qgi0cXHdrPUSMZqb79bfJUVncCcCTt8XQ9ohF3dOGRND
         2udw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762225514; x=1762830314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jkuPUHUimKy1GkV2j4jms8ezPzMfA+mYVSVtk+5pXSk=;
        b=iamtn4rP7bgzBmkh+NbNlBbn9ou2fEwKwRPRQCiaK+sz1UEXWPVxBFoizRHojNJo8I
         UBddLXcuppz55Uj+St6qjQPRwfJsar3e50474M+5tXVQfE+M+tPTYMC23cBYaIizXjS/
         SBW+Y3T3QOyA9AsV/pDTRkvjsYt+/74WJVB8fl54GdUfYWPILAnyj9XX5vhKVTPf6qOK
         yW/YsuoyrMTiJlxIQ7JNai9JotfNt2DBKmZEj5rHhRzMAs8dQ4ylqotUbqYSEySEjoWv
         /S7wTy9hAacYkvvFUJZNx9KMdgZVXwi24uT66lWUmOxR0/xutB9hdFgscWYHtLncKv4R
         z6Ug==
X-Gm-Message-State: AOJu0Yy0HueyXWlybpVUcRfP9/ulriLrYWH7ppwQvYx59SaScaSykbBU
	UvtCq6y1sXDKdUehiFC0mgY5DKq+lx4w7rYIzLJwv6RTvdDsqBt2TilTXbzzfeDk8zT5GV3oqmD
	Y8M6Y0GB1e6cG1EBqkl2is9O5T3NP2ciWDjWNOqQKcA2na7mvqZvHvOLfikYj8nuyTsAFH/uRTk
	bIszS5
X-Gm-Gg: ASbGncstZSxpcwYNsW2JgzRfnSFqUNFoSpM7Uy82VK27Uqsdyb5t4qhr2xWURo/DUPv
	gF2HR07cU+fPhwlBEB8OKkZpBXaS+wHmTITn1ZjzxP8Ho8kgj6xT4nwI8p2FqRDtFFY4Oh9SzJW
	/RGJgb6zAkEuBNGs69Ssi5Sevmf4g4otva9EQ94+gb7TpsLMnLrTpCdIGd3uahLfaWrYh8GN8LV
	jQcgdKmgd8YDdeYZzqOVWwoZ04ZNZB/nZdT3dC34iuvz81nTNVyYiyRG1HUcpQay6DGxBaHae5l
	O5AduqYTuh98OYTM/0XR7ORibKVKs0sK3qqwGKmu/mDwYX25C3v9pyE02UVLvyjIVA==
X-Received: by 2002:a17:90b:3a8b:b0:340:b572:3b88 with SMTP id 98e67ed59e1d1-340b5723ccbmr15221839a91.29.1762225513788;
        Mon, 03 Nov 2025 19:05:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJd5vKmSnQxMzaRaQ3Rd5VhOUdSMMQJmUVb1XRRUOp/C5RPft4OPbOqk0XuYt3iNt5Q/pwyA==
X-Received: by 2002:a17:90b:3a8b:b0:340:b572:3b88 with SMTP id 98e67ed59e1d1-340b5723ccbmr15221795a91.29.1762225513197;
        Mon, 03 Nov 2025 19:05:13 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f87a7287sm615886a12.31.2025.11.03.19.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 19:05:12 -0800 (PST)
Date: Tue, 4 Nov 2025 11:04:28 +0800
From: Coiby Xu <coxu@redhat.com>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: linux-modules@vger.kernel.org, linux-integrity@vger.kernel.org, 
	kernel test robot <lkp@intel.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	"open list:MODULE SUPPORT" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] module: Only declare set_module_sig_enforced when
 CONFIG_MODULE_SIG=y
Message-ID: <r5ssavk3cwtggwdzixgmc3atagbc66nswzsk2ns7aguumtlv4w@4mij5owmfsuo>
References: <20251031080949.2001716-1-coxu@redhat.com>
 <3bf85718-8cea-4982-944d-b4c7a4faaf8f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <3bf85718-8cea-4982-944d-b4c7a4faaf8f@kernel.org>

On Sat, Nov 01, 2025 at 11:10:51PM +0100, Daniel Gomez wrote:
>On 31/10/2025 09.09, Coiby Xu wrote:
>> Currently, set_module_sig_enforced is declared as long as CONFIG_MODULES
>> is enabled. This can lead to a linking error if
>> set_module_sig_enforced is called with CONFIG_MODULE_SIG=n,
>>
>>     ld: security/integrity/ima/ima_appraise.o: in function `ima_appraise_measurement':
>>     security/integrity/ima/ima_appraise.c:587:(.text+0xbbb): undefined reference to `set_module_sig_enforced'
>
>It's a bit unclear whether you're referring to a current upstream issue (which I
>couldn't find as of -rc3), or if this is just a hypothetical scenario.

Hi Daniel,

Yes, this issue is hypothetical and currently doesn't cause any real
trouble. lkp found this issue in one of my proposed patches
https://lore.kernel.org/lkml/20250928030358.3873311-1-coxu@redhat.com/
But I'll use a different solution so the above patch will be abandoned
and will not be applied.

>
>>
>> So only declare set_module_sig_enforced when CONFIG_MODULE_SIG is
>> enabled.
>
>I only see cases where code has a safeguard like in
>security/integrity/ima/ima_efi.c:71
>
>		if (IS_ENABLED(CONFIG_MODULE_SIG))
>			set_module_sig_enforced();
>
>>
>> Note this issue hasn't caused a real problem because all current callers
>> of set_module_sig_enforced e.g. security/integrity/ima/ima_efi.c
>> depend on CONFIG_MODULE_SIG=y.
>
>I think the correct term we should use here is runtime safeguard. The code does
>not actually depend on that config, nor is there any dep in Kconfig.

Thanks for correcting me! Sorry I didn't realize the constant folding
compiler optimization and made a false claim while forgetting the fact
security/integrity/ima/ima_efi.c also explicitly use
"#if !IS_ENABLED(CONFIG_MODULE_SIG)".

>
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202510030029.VRKgik99-lkp@intel.com/
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>
>
>Just minor nits regarding the commit message structure. This change should allow
>us to remove the safeguard from users of set_module_sig_enforced().

Thanks for the suggestion! Does the following commit address address you
concern?

     module: Only declare set_module_sig_enforced when CONFIG_MODULE_SIG=y
     
     Currently if set_module_sig_enforced is called with CONFIG_MODULE_SIG=n
     e.g. [1], it can lead to a linking error,
     
         ld: security/integrity/ima/ima_appraise.o: in function `ima_appraise_measurement':
         security/integrity/ima/ima_appraise.c:587:(.text+0xbbb): undefined reference to `set_module_sig_enforced'
     
     This happens because the actual implementation of
     set_module_sig_enforced comes from CONFIG_MODULE_SIG but both the
     function declaration and the empty stub definition are tied to
     CONFIG_MODULES.
     
     So bind set_module_sig_enforced to CONFIG_MODULE_SIG instead. This
     allows (future) users to call set_module_sig_enforced directly without
     the "if IS_ENABLED(CONFIG_MODULE_SIG)" safeguard.
     
     Note this issue hasn't caused a real problem because all current callers
     of set_module_sig_enforced e.g. security/integrity/ima/ima_efi.c
     use "if IS_ENABLED(CONFIG_MODULE_SIG)" safeguard.
     
     [1] https://lore.kernel.org/lkml/20250928030358.3873311-1-coxu@redhat.com/
     
     Reported-by: kernel test robot <lkp@intel.com>
     Closes: https://lore.kernel.org/oe-kbuild-all/202510030029.VRKgik99-lkp@intel.com/

>
>
>Other than that, LGTM,
>
>Reviewed-by: Daniel Gomez <da.gomez@samsung.com>

Thanks for reviewing the patch!

>

-- 
Best regards,
Coiby

