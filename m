Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFEA19006B
	for <linux-modules@vger.kernel.org>; Mon, 23 Dec 2024 10:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734951331; cv=none; b=Oud87NxYC6TeJpek8BESxF9K83oiYBPODxJ9GuezIxj5mqajaDrupIl/5TA/P7Y9yM3HrZ9UH2aDFCovGAkfCTYbp+mxlau/4BdHxycv6cs7YYi+CIUs0caOmyNIFmhescxI1AEvmdO3eRPmLaJoG5+6FXSIQMZas9Ln5Xc4Pt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734951331; c=relaxed/simple;
	bh=NChCFgCHdT12F0fVKJoZmV32bZqM8IQeLR0MDWF7nxo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=poXmOx5VPzeYI0H9JHVyQjFIy6HNhhu2lHQ5Nsg2siXMMojg2LJFgDnKocqqRPGL0NEP3LCga57wTKQDdkZRiFH5CWVytsTd1Q7p7JwpDcl2vTpGSKPo8Jl2wULuVmq6EKkgmz7x+vqkN4T1EGtXCCKJxXuPeVWZXmJoVQ+WybI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LejdV9y3; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LejdV9y3"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4361f664af5so45852835e9.1
        for <linux-modules@vger.kernel.org>; Mon, 23 Dec 2024 02:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734951328; x=1735556128; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gJO8z+jqb55iABVwB2yHe1yht5XdVDCdEcm8y3HUeU=;
        b=LejdV9y3Gonl0rYcPMtfdB44CiS+POREwppRnT60eI2AEjtevT6xDNjl7pH01NpZ0R
         uCf6IQ+kReCjOb+yW5OLGMIs1rcegCcsWEXpJ/nUCiMnNAPlqaR5865TsmV9jDA7aS6E
         2J1LRGYrLVI250jKEmr2O+cA9S46sYKQLILkkyCWtaP30DazQ1p96lXnvCfpDxfTsjbX
         9IVVm73DBaYYO5VbgqlYmzH+A56yYAV0QbKQCBv7u/Owj5o9t3fmJXexk4YBF4Sfk3RR
         n/rLkgnct/rEm+HtkrRP0JYR2n5klOYKiebc/JeZGcGZ1tUxo5ga6NYkDXMPd1IxciMa
         +PaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734951328; x=1735556128;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7gJO8z+jqb55iABVwB2yHe1yht5XdVDCdEcm8y3HUeU=;
        b=dnkyag27LU03hqlHcjwE4E49HmpnP2/e4pjUb2mgkBmxymC4E/PJictp6Zq740FJ7F
         OSjM9/XT4n4cvk9moZfVfJH+k2fuAQRQiYlMA9bQhGhtgJb5BIfLCL/irXinRMRfeORf
         qme1br7X+gAM+526ajmTZSlPYB1KytDT+K/4fJ+mAY3hHcZ4+kCX106G+otLstPO1laX
         MA82AqgAIkkg4lMVOUyB1QMqyUgcMDI0voyr1Vr8w+ehdrXLGVP5v/062LF+2s+ZZw+N
         BWsxCngiM1ZvU7WiKXxRYHi2qLORNULTghOXTe5Z9dtgdb59nyRPTP24rfpg1uNZrd/z
         oSug==
X-Forwarded-Encrypted: i=1; AJvYcCVz5Lk8WDO0mJLZRTlFE5HX72VvwMq1cRAMm4olD9Nu1ALQcSoCO9sQWNyvFgfpHL/+/p/maF3nlD7Ccj3h@vger.kernel.org
X-Gm-Message-State: AOJu0YzgfgG0x1fLJQdlcOb3keLd7de1gVUM9kRG6GzxZdwK7JgXrriR
	xtEokRDI1Fuoca7z/FcdbfibiQRMkF6wCZ+ZmENGfX/yaLvyfluEadEo9/Pbr7s=
X-Gm-Gg: ASbGncuNUGeYle5i5X2U2Z06Rpvl9FKWgXxkt0BQbM5w/TyXJAVqu8LQrqjZSQUSXAK
	Jh/6200BdA0oIDk4yIchZPhKdsjxz+qFfcoUL8bexAew3wtwJxvF3YyDTSRgjcGJOxw+G0GD963
	J8S1jnVE5GUaqRI+nGmqdm23spPds/Spv4V1zSxKFDSSN+WklERfDEyP8acn8BaGuoG4nrkhmM+
	HSD8t+u5mq+WCmCs5/kS6RJQR+gZSFdBnBrCYO8VgOjc7LKZSCzzvDzxa8T
X-Google-Smtp-Source: AGHT+IHnqbaULwPw34hn27huEI9Z/08QAl40AzJEocWdys1Q7HHYp51KVFMJX8F2C/OGksC5k1Hy3Q==
X-Received: by 2002:a05:600c:511d:b0:434:ff25:19a0 with SMTP id 5b1f17b1804b1-43668b7864cmr93090065e9.21.1734951327727;
        Mon, 23 Dec 2024 02:55:27 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4366127c4fcsm134050965e9.29.2024.12.23.02.55.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Dec 2024 02:55:27 -0800 (PST)
Message-ID: <fedd0c6b-a870-4b8f-8f52-6e11df936678@suse.com>
Date: Mon, 23 Dec 2024 11:55:26 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
From: Petr Pavlu <petr.pavlu@suse.com>
Subject: [GIT PULL] Modules fixes for v6.14-rc5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The following changes since commit 4bbf9020becbfd8fc2c3da790855b7042fad455b:

  Linux 6.13-rc4 (2024-12-22 13:22:21 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git/ tags/modules-6.13-rc5

for you to fetch changes up to 0b7a66a2c864859fbf9bb16229c03172eef02c05:

  preempt: Move PREEMPT_RT before PREEMPT in vermagic. (2024-12-23 10:46:38 +0100)

----------------------------------------------------------------
Modules fixes for v6.13-rc5

Luis asked me to look after the modules maintenance for a while, with the
plan to rotate it with other recently added modules maintainers/reviewers.
This is my first pull request to you.

A single fix is present to correct the module vermagic for PREEMPT_RT.

----------------------------------------------------------------
Sebastian Andrzej Siewior (1):
      preempt: Move PREEMPT_RT before PREEMPT in vermagic.

 include/linux/vermagic.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
