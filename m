Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CA91D516A
	for <linux-modules@vger.kernel.org>; Thu, 13 Feb 2025 15:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739462370; cv=none; b=PcEKIR8MDIOJaKoZI+PO8Fcmeeji6z/tniCxzrVNwYBlyW70a7pXWYrlvN3v8pPDgZVM0ZmQRZDokKcXRO5kfWk9JWpHQptCZleL0xFqneueM9cZ2ogYAiRX8c3VYSIyRgYVxwe1AWSiVn0xVB+MGkH6X22P0aASLptlEHW2fYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739462370; c=relaxed/simple;
	bh=xPGcVznUvLeFy3uiczY40uRubCYunGOPAh3g1r5/5j8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WhMFIiPkhQIODQyFzyTSr1NkQrOjMnQZcb63UgZF62aHP94ZOViHyZF6OvyLgEyMefCVciDSgsKV1sC2c996ZyEhzhdKfQ0xQPKHxP2VCFy8q38uEzIIi73ZVkNTmKpNMixddAU6qQulvBBv3Tz95y2095fYheFMnd4faWl4aVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JwXF4ZR+; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JwXF4ZR+"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ab7ca64da5dso204310766b.0
        for <linux-modules@vger.kernel.org>; Thu, 13 Feb 2025 07:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739462367; x=1740067167; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xPGcVznUvLeFy3uiczY40uRubCYunGOPAh3g1r5/5j8=;
        b=JwXF4ZR+zSLQklfH8u39dxGYOiW9H08Tlvar1VUnElOC00ZbPYluj9HoQ6cND1ES3u
         LY0JvnyTWfEYhUYyCRnGSNL1Qm0OOQBS38VfMQUQFUqlFiAT8i+7fIxTRD3bgywgC3Wx
         2QodNpZyw2ylOdunv+rZGN3jun8U1LFxmnipa11uPEdYUSwskh/dcZ4Q341dnZo74eCX
         KZpVxA837SlUBn5u1GmBvLX3BkEg0USzBNZy0saN0OZRaLuKyxxDj8iGcM0kv8svuHYh
         gMjf3VDt262hXNusWT6ufoPH4Pq2WknOB9OswvDuU4Mctvw5YKAn51PtCFigFBKyk7cg
         mXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739462367; x=1740067167;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xPGcVznUvLeFy3uiczY40uRubCYunGOPAh3g1r5/5j8=;
        b=JJ700hGn67wD3u8bh/qCAiUIeyxwv9680/CB2blFFAluKN3PF9/5JfeDRM7VNNbXOR
         dsIhXkR5m+ca1kLj8BpZ6YhvLFsn6V9rmQlQX6SZD3wITdcCnfmeN0nDGt0xuMG7Lt52
         2qEU0cXljwvMZFoWObqjyNJ1wsGpTd4NakYv788K6sUuZ4djKU9Qp5hBo2CF47qA6/kQ
         bZZbh1uuex63YK//Zvkmn90FhKMAnUlgYprnX60yAERlXaWWemxe79KQYiShSuT2Wh2S
         h7GqM1cHAGhG5Jit/lbSYrviPwZqeHL7Oqc9Akkqjw6flTbC7tgGF+26TlfUPFhaKOF3
         d58g==
X-Forwarded-Encrypted: i=1; AJvYcCXAQJ+OlPcLgx+UWtM3sdwD6H1x4O4Fw08Tg5d12FOISV4ywU2pSIdWpwOtI1mPR5x2dUp8SfU5p+TsI8wI@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6i7yay/NKlDjMhJUpsT6cTTm9MFaZepNvwquemRuo7x+RyLiQ
	cjTvN+Xc1dgzK0MaaWFXqus8NPr+Nj0ZrfGUw03XoKPBbD13drMNfoEilTVEvKtr+5IAluNNj8s
	t
X-Gm-Gg: ASbGncsiS0DoG29G3khqcVluRGDQCwTUzwdbSamkZ9YgfQjJvKynRDgxycstzNZP490
	E0OubUwitj7CBen+mYDoSX5PSFsHsiHpAG1q+CW9XjQztBO7DmmbiL4dT51Ho/l9O0iLIzsB8hO
	aCiMuSh3TrU8u63Hfji/bi/H9TUWSAhMElLHbMOPLZTPvT7jTvwkHHvJdTTPl7MQceXqyddVblg
	os+J2+diiFeRhAE+Y9cw25kOfSbdyl7CW+PHNYPIxMUyqX5T4now6oaDPKP0p/IoSwil7KLLOl9
	Q7FcKyE5nv29+9Rmf84=
X-Google-Smtp-Source: AGHT+IE1Ar+qat8FNp9iK4XzjwY3o0QaCkr8h1CdQyqi/nSCp7oGodOaTwvP54IAi0qXjPHA1g7F8g==
X-Received: by 2002:a17:907:c283:b0:ab7:cd14:2472 with SMTP id a640c23a62f3a-aba5150b35bmr293992266b.23.1739462366827;
        Thu, 13 Feb 2025 07:59:26 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba533be1e7sm156907466b.171.2025.02.13.07.59.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 07:59:26 -0800 (PST)
Message-ID: <450e8088-c239-4738-a996-834734f770a5@suse.com>
Date: Thu, 13 Feb 2025 16:59:25 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] kernel: globalize
 lookup_or_create_module_kobject()
To: Shyam Saini <shyamsaini@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 code@tyhicks.com, linux@rasmusvillemoes.dk, christophe.leroy@csgroup.eu,
 hch@infradead.org, mcgrof@kernel.org, frkaya@linux.microsoft.com,
 vijayb@linux.microsoft.com, petr.pavlu@suse.com, linux@weissschuh.net,
 samitolvanen@google.com, da.gomez@samsung.com, gregkh@linuxfoundation.org,
 rafael@kernel.org, dakr@kernel.org
References: <20250211214842.1806521-1-shyamsaini@linux.microsoft.com>
 <20250211214842.1806521-4-shyamsaini@linux.microsoft.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250211214842.1806521-4-shyamsaini@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/11/25 22:48, Shyam Saini wrote:
> lookup_or_create_module_kobject() is marked as static and __init,
> to make it global drop static keyword.
> Since this function can be called from non-init code, use __modinit
> instead of __init, __modinit marker will make it __init if
> CONFIG_MODULES is not defined.

Hm, we should later clean up kernel/params.c to use __init_or_module
from include/linux/module.h instead of its own __modinit implementation.

-- Petr
