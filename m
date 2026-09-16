Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122B33C1D56
	for <linux-modules@vger.kernel.org>; Wed, 16 Sep 2026 07:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789544727; cv=none; b=Fsf08C0DMLiHoKeK1hlI+x9X2vwi1MQ/53xFAxXhPFKBXW3ZWGhjb40iFkJdSEdXVVIrkYPWZktknl9eQgHioXM0RZ08u2xp3LGXrA22DnNSlEAWNVNRenUuQIXwykvHmPIldCyflx+25vBRhfqi2NeA7bXsdT8ImCvs0apo9EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789544727; c=relaxed/simple;
	bh=+54NuxISumPJe/kOdveNbMQVvj3n/4w+75nBM9JTe54=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mG4c8PXh7koVTrdMTQpggEOzsUaV5TlqSyQRtvJY3Fr/vVEyH08MNO0xkNOOWhyFLdNeUG4ogfPJZne4QglFklznv5XIodTlcEctp9YkZQMSXDyBMDOJZoU6FpFXydYJBWl6vWZPu1XSbCapFdOSdpBcgphkcGgez5h7xnJsvDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFm0Gq3W; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFm0Gq3W"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b910bdf2eso394555a91.2
        for <linux-modules@vger.kernel.org>; Wed, 16 Sep 2026 00:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789544713; x=1790149513; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+54NuxISumPJe/kOdveNbMQVvj3n/4w+75nBM9JTe54=;
        b=PFm0Gq3WrEM+XyHSM0m6jwbZXyXxeiLyT77s1WMuEe5N5/3crM/jaBQV1a1TrNHBsd
         F/ZxQ8dUxknTJ0TTku4HyJsyLf79nqLdxus6lNAoLNw+bB4qkMxDhDu3PSEmn9aAFHB8
         1TI0H5R6T6qCVdl2S48XCfEbh3AmtrwR6UO/AWMIuybjknFMumWosTF5p5Pm4j4k9iRE
         iiC6/IxzFECl54mtcLlU7GBrEogDOGttgAf4d0uNOK1yQjscrdJyjAh/gFyUa+eneOWe
         6M70qrZQSnp7XdH9UXz/4I6xb8vuOihnoYwpw2uMnDV9EUD56naoqxNiP0GJRAtw6zEL
         pJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789544713; x=1790149513;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+54NuxISumPJe/kOdveNbMQVvj3n/4w+75nBM9JTe54=;
        b=QcOeshTmLQlDCjx3n7gl4enumaynHx2qcKKWaTIvtdoor3iJAs5O2d7ZMgI+t1il4a
         sg730FJ0qnKySZXYUOFelG2BCYHRzR/tmox2gclbWY74RJUwZ08twVzlDf/EVyXE06Ku
         /GWB/nhztkOgEgETvgpCnBXA4EuT0pPs1suJSCiEsMTkaUTTXBRlnXLnLS4EWh9d1K0l
         EFJKIXlMishfiPvH00IAboiYrkvYt5YAoPdwtgcLTkDDf5LkzFBjHruVaAhW5tnmI4T7
         sQtcDx9PtKbj/82xrwypkzwEd7vImklMM6+49BtOmMBckR4cpOzU1MD+hT0SUTGaJNwJ
         u60g==
X-Forwarded-Encrypted: i=1; AKwUvByMyOGISGBQ/omiW5o/M9vzGUma2Q6o6YBlxT/UKDeSDhZ9dqqREkww9NRRCGzByZeDxt1cJkyqo9jRZBH6@vger.kernel.org
X-Gm-Message-State: AFuF++lisaOil0HtqSCBZtDChvu1PeSHJ+gPLjBN5Ooc2zgF1/2bDKOt
	pXYHAm2A2B46a5RQBQsL67ZCWaZZAhRs9lxxS+XR8f/jvxifoDWmYkYv
X-Gm-Gg: AYBFou1jOJ3WP4fauAyVbi45bo/SOcbFJZUl9Ne0LWBqct3ZzUynaur7nQrh7c7Rq/c
	2R8yD/EDBowuUN+F6Vi2yln1QuEBkTlnc1yswGcC0EhpO71UYCRhiodByjvV6lOrmLvkHfN3J41
	6gxwJJkAOC8umr3osu6awrM7Y2aE4NJ5h9D9SprPydkeLrq/V39MQ8CtN4sTvWaJZOxr9QBWHVS
	bt5GuQ+JXmJQ/OjanNHKns3ykSqiogBuUN4Y5IfBFePt0XoGQe/Aa42JbAkZsZ9jyOK2Ihba0iq
	oUZZvwC31LbgDlgjDhWuXtV/UrKrv7TFtqC1sUdYgX4YwYJuD8QW3M8NqlsfeYVnzoYEEKwT5wB
	iq28K1MMIr3GY4KkOirWPWY65xoHS+I9FEfawZ/W+yHQW+WjJWMeSZh4wZkj7VPbDtVICDZRvs5
	MxpasXiGECABHGF2NGCpvmucDIhrW/cTfbBp+wjLKXYacdu3SdFPpaLpkRX5YBUH6AaYN+Dx195
	pGFk1JCrL1hPSRSYwNmaxcgVkk=
X-Received: by 2002:a17:90a:d444:b0:39e:b0b:4d1a with SMTP id 98e67ed59e1d1-39e1e2e50eamr4358854a91.6.1789544712860;
        Wed, 16 Sep 2026 00:45:12 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1d0be48csm848785a91.3.2026.09.16.00.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 00:45:12 -0700 (PDT)
Message-ID: <cf7c21aa04b250d03500a855aac6f15f19eda816.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 03/18] libbpf: Support moving permuted BTF
 types into split BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, jolsa@kernel.org, ihor.solodrai@linux.dev, 
	yonghong.song@linux.dev, song@kernel.org, qmo@kernel.org,
 martin.lau@linux.dev, 	memxor@gmail.com, emil@etsalapatis.com,
 mcgrof@kernel.org, petr.pavlu@suse.com, 	tj@kernel.org, kees@kernel.org,
 bpf@vger.kernel.org, nathan@kernel.org, 	nsc@kernel.org, arnd@arndb.de,
 puranjay@kernel.org, yatsenko@meta.com, 	atenart@kernel.org,
 ojeda@kernel.org, linux-modules@vger.kernel.org
Date: Wed, 16 Sep 2026 00:45:09 -0700
In-Reply-To: <bd56c5cb-fe35-4ce6-91b1-d83fad7c422f@oracle.com>
References: <20260901165757.801449-1-alan.maguire@oracle.com>
	 <20260901165757.801449-4-alan.maguire@oracle.com>
	 <98c9c5838b50871b3a138d2104450774268644b3.camel@gmail.com>
	 <bd56c5cb-fe35-4ce6-91b1-d83fad7c422f@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-09-16 at 08:33 +0100, Alan Maguire wrote:

...

> Thanks for doing this Eduard, it looks like a really neat solution! The p=
ermutation
> approach - which is really a permute and a segmentation - felt a bit clun=
ky and
> doesn't feel like it belongs in libbpf really (it's a very specific probl=
em).
>=20
> I'll play around with this a bit more, and with your permission maybe we =
could
> include it in the kbuild inline series? (I'm splitting up the work into t=
he
> libbpf/kernel location support needed for pahole, and a followup to add t=
he
> location info)

Hi Alan,

Glad to hear you find this code useful, please feel free to organize
and change it in any way you see fit. Looking forward to the v3.

Thanks,
Eduard
