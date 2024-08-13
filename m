Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E662E630
	for <linux-modules@vger.kernel.org>; Tue, 13 Aug 2024 17:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723569564; cv=none; b=Eg6Zdz3IdZ6GBTqZBr5fZ1v2UOtElp4e3epQPETNUQb1tEQpEj2lss+vX1Y4XtdMKJz3TCrJNlC7jYhzXuSX4chtkVRGcr4xlgt3nctDMu4uOUiycLXPgwPV2nkNcL9adfD4tzS+gB81F3l7tPFPdUb/UKvoyH3BBrb+Kk+4VMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723569564; c=relaxed/simple;
	bh=X423r16aZtNzHg5MDltfwHuoaNtuCcsCxynkPe19LSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hHlhGo161LOuPy5VLcXXgOasP3DgNithU0WppK86B4vDkMkTJyjFpt8jTISl3PObMLyDvaEpfIULhp8Lj/gd5YW1WzLyhJ+lkQ/bx+mdWCeyb77Bid+nczqY56RSM8OfXnotaVr4DZeNt0fddtcrwlS0Q3yDqKPo+lPdAH7fVKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgeJTFSQ; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgeJTFSQ"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a1d7bc07b7so382294885a.0
        for <linux-modules@vger.kernel.org>; Tue, 13 Aug 2024 10:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723569561; x=1724174361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QyfJBHDoq79P/X9WfEpldI5CGsK1sWuibMC/+gwK3TI=;
        b=bgeJTFSQxo5l0LwOJ1r0822onvXTZSNASudxdnjNJgLPo6HR8GFvxEWV/5AzOvUDtC
         xvhI4+SlJWX+v6kbsUyCDTWLDAGHm/9LMAiXKjFA5w6Rkfclk/wfv7AtYTM/D8c3Sy6O
         0vWaVLixRKG0lu31PeD5foAnHHRZR8MR5XIFJb8CO1LwQ0p/jBBOvNNIOAzLPJON3pEn
         rov5ffw+aw/GNn3YgNvqmg+o2N9FQc2DfgxuF+OLBOQuifN3CnEn/4zky4XqsRdPEWde
         zwuZtT4Ujbyv+XCPt/4uHimwvZmsdJjwkBYtIrdi59856tk9pnAzKQ22QuOGcFc2afat
         quLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723569561; x=1724174361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QyfJBHDoq79P/X9WfEpldI5CGsK1sWuibMC/+gwK3TI=;
        b=KZECgejfotZEuKHpExioy302JDvFVI/hHDWfPigLo1Lzpxl2Swl6GMjQGzyWAdkaDh
         Dc3r2Pp9u/F704CVVFcE6aBR/X1Dm/hUA3RHplABjBwJ/YpOJZr7BINrEvEI7mNaRJg1
         2767iX/tUI+fKrNQZ7jPNvvxctULtKFImP1wxcGoP4nvUIkjZkF1WpmAmQjCwNSoaEx4
         WMmhRhvlh8B2CD3ryXqwTAXWQ6OtkNvIlGR1ycED3FTY2e5PjFu8DGdS3oyiWZRG7TJZ
         QSFBMFgqzLfWgtWIQR0xBLrYB5pdRZX4WuVV0YLd5ycpEwIfEpjw40/G1ZkFMR0mhfuD
         69Qw==
X-Gm-Message-State: AOJu0YyBI/AJCOV7PHQaf0lkVjbzlWKnLz2Bs3Har+fjOAULGmDg4cUr
	EyB7+VwO8NppagPQMTvGPoRd1rcVV1rz/RDStbXhkR4CaWWVob2yWuPd2A==
X-Google-Smtp-Source: AGHT+IE3jlLcjlpI4a7TisEIfbwhjl/cTZv+xwwyr6ZllIeemAOduLiRhnqYDSAe/6BuVg2/2S1dwg==
X-Received: by 2002:a05:620a:1726:b0:7a2:c1f:ccd7 with SMTP id af79cd13be357-7a4ee3e662bmr26509385a.61.1723569561204;
        Tue, 13 Aug 2024 10:19:21 -0700 (PDT)
Received: from ldmartin-desk2.lan ([134.134.139.69])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7d649f9sm354961485a.19.2024.08.13.10.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 10:19:20 -0700 (PDT)
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules@vger.kernel.org,
	Eugene Syromiatnikov <esyr@redhat.com>
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: Re: [PATCH kmod] libkmod: avoid undefined behaviour in libkmod-builtin.c:get_string
Date: Tue, 13 Aug 2024 12:19:15 -0500
Message-ID: <172356954026.793645.2230396150902785835.b4-ty@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240813141727.GA23657@asgard.redhat.com>
References: <20240813141727.GA23657@asgard.redhat.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 13 Aug 2024 16:17:27 +0200, Eugene Syromiatnikov wrote:
> Static analysis has reported a potential UB:
> 
>     kmod-31/libkmod/libkmod-builtin.c:125: use_invalid: Using "nullp", which points to an out-of-scope variable "buf".
>     #  123|   	size_t linesz = 0;
>     #  124|
>     #  125|-> 	while (!nullp) {
>     #  126|   		char buf[BUFSIZ];
>     #  127|   		ssize_t sz;
> 
> [...]

Applied, thanks!

[1/1] libkmod: avoid undefined behaviour in libkmod-builtin.c:get_string
      commit: 5c22362b6b97af9c6b7587f0c3450001e9893115

Best regards,
-- 
Lucas De Marchi <lucas.de.marchi@gmail.com>
