Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AD23368BB
	for <linux-modules@vger.kernel.org>; Thu,  9 Jul 2026 14:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783607505; cv=none; b=urRASGobrPqBOQkGCu5tjbEzsryQrmpTfvAYk/sCytiy7bOZ0ZHNuxt5wCe3VcMDsCohFATQkBUu4EF0XriKE0uemWlRIhc1M6NfFkFSoV5QjUwq+UdI9WDLT16fClJ2m/dYngL9LMxpY5i5YyOsdsDhpiABG8guj8M531qU4qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783607505; c=relaxed/simple;
	bh=qcVadA0fPRp1PvqsrADFsaJsVMvOnqgY7ix/aHdVcEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=cq+HFmd8huBbsdVAtlEXBMX7CDQGzg6RWRzFI8iaXXewqsmuwrOHRjkNgBCoiV9zC2pWZ7LPI/abWG+emh3tZTaFi+W0/LB2z1LBRELHansVCFivpNNyOQTP7hRMWQb3PjmdA3FO0XHbFhHHVgG/m4qnJN6sUo9lxJUhM7Ult6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PxZlHnVa; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PxZlHnVa"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493ce08a75bso8087075e9.1
        for <linux-modules@vger.kernel.org>; Thu, 09 Jul 2026 07:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783607503; x=1784212303; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jf8pxQ3pKgmqhTvEn81gn0s+ssKwrlgRk94XXYEyXL8=;
        b=PxZlHnVakFqVtOyIZ6/UrYF3Au4Ja/JXYLI0DCRNibR8eZH3mfBygOOPeQRQvV3Nm2
         B8ZA6Pj6DL8DsQkwYLfQkI91uje5NQdc+q45froHUygvvDQgnSLY1ZGQFAjcNG8dqqFz
         evrJZshSKI2vf3f2eErUWhNP1ohecd+NvZ6YkFXrUedk1bXOBHV8wlrpEkEwfwoRdvoq
         ix4R/Zc5kp+WMPljtlQj29pyrUw3dHdItksxOcQghB1ehsA6RRYRvQQnTe8/7jUnFTdZ
         q5JZ5ydj64ghZCMDjgd8KJp4NfjeBhZofoOetjF+eiAaSgV3AoXmH5Q0xgUAdz4rR+C6
         dC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783607503; x=1784212303;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jf8pxQ3pKgmqhTvEn81gn0s+ssKwrlgRk94XXYEyXL8=;
        b=H0xOzura08rmbAL3imB144HlNNGPadcOnlzNJjUkW2cE+nvE0rsqByEfYYASBUUN8z
         1HCKqRzEEN8uhVSFK/6f19/zopQjhq+3CyyrG40VDHlsgAUFJOyS238WWidSOOG1oUsk
         nDunKl65/XXW7zUggR0uiDJkVDomlkjfLlc+RvxPPFTcDaonuY0GnleFk1rr+7XqFjTZ
         RCzE9fk4n6B+WE+PBpSyX4LsrTLZoaK1c7jelHTZ+4PQznMgXaNo2gnkpfg8EpVkT0Lq
         H0q7fnT0ev76MBDu8epVqy1ppcB+nY99I+GTTL/2Ti99zU2uK9plkJRPtamAlMYrs4ZY
         jTFQ==
X-Gm-Message-State: AOJu0YzWIT8B/Y0OajglnPIlxY/IPMH9yMlk9oFn/qyIyNuhzRzzACy6
	fwE1/cxeL+o0+8AqHqk8vmQ0/rPw9V6GiwDDXKlTtec+npdbow2Y2n3i29y3FhiQO+2/++YOnjH
	dHdYSnUTgxw==
X-Gm-Gg: AfdE7ck5aajDdMLGsMOfisQmiO0Vgslc9D8Ewgb8oSh0Fty5fkohXymwDx0Dd8rLWqH
	zdlJZEFkMhvQGmsXo8pvncAPkGGLGjc5X88dn/fIPtucO7Po2FCWNULIchv+wG/rsE35UYbri4P
	8qBvZBbunGrXt8iVnUx1SMKk0JEkjJzHMx1syD9NNbdD7Bpe9aOS6JTsDdSzDDaju+4aNVJL1/G
	nEq/tbm6zqiSS7NbHEostGrQODOmSnNtulwI946DEwdXSn3BIQSafv8jzOTDpUnvDidMyvBWpKU
	64MdBqdAyk2ZqoCM596vjOTNu8bT+OJI3Jr3/9sjh6B7rFRDtdkI0yRgMd7M/bItkMMugoGjDZF
	AiVY8Xtfn1MtDFamWTWj2tLFmSiGr/NAL5Tt0n0I2/wLzdq1Gk7Nmtj0rt0qwPr2eQ0SisYz+2G
	SHRqKZX6HUnHx6MZZbQnPyBDW6MvOF7ieCSw==
X-Received: by 2002:a05:600c:6286:b0:493:e53a:8982 with SMTP id 5b1f17b1804b1-493e68643ebmr73599955e9.23.1783607502499;
        Thu, 09 Jul 2026 07:31:42 -0700 (PDT)
Received: from [192.168.42.79] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f214d2sm50599601f8f.33.2026.07.09.07.31.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 07:31:42 -0700 (PDT)
Message-ID: <79bba1c7-01f5-48ae-8b0d-07e4dcf0127a@suse.com>
Date: Thu, 9 Jul 2026 16:31:41 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: About THIS_MODULE
To: John Garry <john.g.garry@oracle.com>
References: <610fc63b-f3dc-4824-99fd-907fc96f3194@oracle.com>
Content-Language: en-US
Cc: linux-modules@vger.kernel.org
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <610fc63b-f3dc-4824-99fd-907fc96f3194@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/3/26 5:33 PM, John Garry wrote:
> Hi all,
> 
> I have a query which I hope someone can advise on.
> 
> I am adding a library API which requires a driver to pass the driver module pointer to the API.
> 
> So we use THIS_MODULE for that purpose.
> 
> However, adding a sanity check in the library to ensure that pointer is set is a challenge. Normally we would check that the module pointer is non-NULL. However, for a built-in driver module, THIS_MODULE is NULL, so rely on the non-NULL check.
> 
> Any idea how to deal with this?
Right, a NULL module pointer is ambiguous if you want to distinguish
between these two cases. I can't think of a neat way to handle this in
a library API.

One option would be to rework THIS_MODULE and introduce a reduced module
struct also for vmlinux and built-in modules. However, this isn't
a trivial change and I can't recall a case in the last few years where
this has caused a specific issue. Additionally, if someone forgets to
pass a module pointer somewhere, I would expect it to be fairly easy to
detect and fix.

-- 
Cheers,
Petr
