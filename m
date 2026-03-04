Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E07388379
	for <linux-modules@vger.kernel.org>; Wed,  4 Mar 2026 07:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772610754; cv=none; b=PUopz2o6PKFtZTlUh7KtjKnOOkcd2eG7mOONkqi/4Z8OveWCmnUHXX9aSLWecXr4n+edR/KQU9ktDJdIx/A32oQIh16bzxsiHsC2+MNM6bWRnEBtjhXyMR+Wu7cPQK5JzdMV7YMMvea82Cz7OtYlAjR5sQr0whN67eDczmvnTbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772610754; c=relaxed/simple;
	bh=EcLDMvBjjbTD/cKF5y1BkO7ob6e6OBIu3jcREkFicZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a+cXLbap6rZc8eKYPHwlzeekGPx66dlpZ709VAV86Q9yOGfjwZaZVhbtQqE3IA6+a0+gGVGF16BxT6N2AdYDaeSlkCh73RONyk+Cp3RqOvt5VAvKgn1PGmQC5/+s8Kmy2w6aGaWq6999wybryWfkbCq8fL5JkM0kJaasQPcN4Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FNnTPrmD; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FNnTPrmD"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439af7d77f0so3147998f8f.0
        for <linux-modules@vger.kernel.org>; Tue, 03 Mar 2026 23:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772610748; x=1773215548; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iaji8MiSwOMoEhpHJ9TfGIIdRoqWhERpR7BNI+IYVW8=;
        b=FNnTPrmDvPeJsl7KgOkZBHjigGbAfeWKOyNkXPj/ux+4SYrQn4MTPSHMrouYmSgqIa
         YuFUNmIKbBGjpl8HC4GdNNkeY3ChhyRlnRpH4V0ri52oDep3hlSTOoliQedMT0Q80eJ/
         u74NOjzU2/l3poPflXJgxfZbtt5Jd1H9iW1nzjA/GbFpj7Don+kWtej1SpQqfk5AYi09
         Eb9dLae/TK4h5q3fJZKI1g95C/udZxLAoLe0Upb2/LygfKo5T5+smDUdi37tfQZDsldY
         1va/Z7NSVaRop+Elt1Nxco58Kr4VF80cTnrvUk2M/x5YabCEcP0q7FV2F+ubPjbxO5dH
         6ovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772610748; x=1773215548;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iaji8MiSwOMoEhpHJ9TfGIIdRoqWhERpR7BNI+IYVW8=;
        b=Jn8FDcyXoutNTJDUx/27z2M7scYAZ81vzqZp11GC0daZ4kGKIIFO30duX4m2uU7e2E
         jV+ty2ARDwzbfM5tFCS3HzylIMObRFIEBAjHOeCbVZk1nbKiX6tiMFVIylM63VIuupia
         /+124LvpjmRRAzmEO/CAF/dCZj0O3811AFUYNoRj4ZNmIIVFfk+8Ks3jzJz9asBLeurf
         vW/5lbVpuhKFqDIbMoyU2dG6pjzUPs7d2g+/Xc3M3ZeyYtWSLgrVO12Y5wBeWaeSItMo
         mrtW/SSW1O6SvBqB9avgIZpx0Xj9GW/utAcX5RuTzLQy86ChqD63tj/T632pYTGvVUOt
         AB2g==
X-Forwarded-Encrypted: i=1; AJvYcCWue868DHvbjX0oun/WxlJ6GzxUAcGLFgM/7azwtofKCjg7Hw7NJchI1rORDFelK0tF0pVAqZqiWYCa5XBk@vger.kernel.org
X-Gm-Message-State: AOJu0YwXPEWXIzCG4SaxYNTjyskka/WSQ43ToTUqi3HV88pVrde9B3Gd
	Z+/sFzpYkAufwsMAqxLkpxTxXVfpn8LuYfoVy8VSIM4oMfMIEXHcSqx7uChY3757Jg0=
X-Gm-Gg: ATEYQzwf6kSRK60LJnjGvxfGv972KVQRc5k+GpwDPQISqI2cqu/YLKurhVVfdt/DrBb
	1fQgvryYNzmG+j15LoD+WjBjtnab0OXAdZm+PwTpM+QBaPq7EUXTp3aZ+niGJMusnzAYAywa7tk
	IOGlvW0qWLnvQior/fEptnG0xjl1lBb/ZECVYuPaE2rUluPVL4lN+jJYvzdBj+dcPaOA2bTNjl9
	+KZ8toux7/hQ2oVrztCC2RHjA58EuSIdplHylnzRGOkZCqXt9w6gPieyJr6k/1Czc6rhzqPK/dT
	+/xs88bdCTtIN8kY98nfE3Eep9ug0iE1XB9OWaChY0N9L/MPFH//Hn/YQhUkp4SaoskFMEMGHKV
	AXRv5BJktneMsjg++lAur2rijhQ0eh4wSa7hykuOt27iyLGNPBI0SRoJLMyf0sK88Seiqom7McP
	E/EcFr40iE3YX/XjQeHUNIYWM8LxpAgE4IADxLg3JzLu23GtB63p16Ih+OP4jRojTpkw9KOt1H1
	EpEcQdhoyfJLt6Zj4DdIsf+ToQK7gs4tHyCpiTOKNeXrpKOohHrlx5j8WJZPy5R8gjWT2ZAGqiB
	at8U
X-Received: by 2002:a05:6000:4301:b0:439:b886:20d3 with SMTP id ffacd0b85a97d-439c7f7e5b7mr2101563f8f.15.1772610748337;
        Tue, 03 Mar 2026 23:52:28 -0800 (PST)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c60f764sm42229774f8f.3.2026.03.03.23.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 23:52:27 -0800 (PST)
Message-ID: <97a56169-b71c-4ad0-8992-c6e2d381ff02@suse.com>
Date: Wed, 4 Mar 2026 08:52:26 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] modules: Move 'struct module_signature' to UAPI
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: David Howells <dhowells@redhat.com>, David Woodhouse
 <dwmw2@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260302-module-signature-uapi-v1-0-207d955e0d69@linutronix.de>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260302-module-signature-uapi-v1-0-207d955e0d69@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/2/26 1:42 PM, Thomas Weißschuh wrote:
> This structure definition is used outside the kernel proper.
> For example in kmod and the kernel build environment.
> 
> To allow reuse, move it to a new UAPI header.
> 
> While it is not a true UAPI, it is a common practice to have
> non-UAPI interface definitions in the kernel's UAPI headers.
> 
> This came up as part of my CONFIG_MODULE_HASHES series [0].
> But it is useful on its own and so we get it out of the way.
> 
> [0] https://lore.kernel.org/lkml/aZ3OfJJSJgfOb0rJ@levanger/
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

This looks reasonable from my side and reduces code duplication. With
the removal of MODULE_SIGNATURE_TYPE_MERKLE in patch 6, as reported by
the AI, the changes seem ok to me. Feel free to add:

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr
