Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34971D8DFB
	for <linux-modules@vger.kernel.org>; Mon,  2 Jun 2025 14:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748874890; cv=none; b=ufy04yKWbw/c3+2/ls2mUZmT4eOeJJMoHe7amDPiw65oaslTKY6y6yhx0axcQ7LwPXy8/H0RhgTnVCvghKmSmYsS31cuzXJivM56+jDJbAQfvIMF/yj0zmR8qC/yN20gB0n0G1melQJWpjP/oKxTKWMgS8eGvpXDFdDV2Sj3VnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748874890; c=relaxed/simple;
	bh=fdXPgavyQt5mgOY4KPBSmJIpb0mzHh83apYdqJ8dLSA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=amM/TslOuokxVY9zt/YGundxRhQKmdu0GfwQm3LUIIW9H0UjCgNEoSc7AC//ZpDoF0Dj6kmQVPKjZ7WLp1yS/KmaWWMlQV+Z2G5EdgdR5jRLY2sMkI1d9GplsyN4sEdF33C7QRJvn6ng2CAqlxL30HRUTk9WCCNYmSkLaDWxK80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ORPbulRk; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ORPbulRk"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a36e090102so2563081f8f.2
        for <linux-modules@vger.kernel.org>; Mon, 02 Jun 2025 07:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748874886; x=1749479686; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pgdnf+Kl0k261W4dUlc5FhPL/oaQJoIfsI8FOVh0YC8=;
        b=ORPbulRkFlZONh6pW/NoxqINtK6idxWb/XQDCDbc98WfRl/bHpY9lP5rGSXBFOV+JG
         QIWaYKtU5fwT3AAbvkYI9JC9HrQ3okA/OJHARuHw8HlNIiZ3FhHtLTrCIt2qQJiKQjmJ
         Kmin4KCt07q6f4uT2ggCvMIG449Bm7FT6j+nGdVzaSQ5u8Xg/fmudGnN6oormuuuZfrq
         3CfOD0NUPq5JTx+W8ewyI06Li2ARds69vzI7UXCFOWzaRK1JPilYmq+u/fPuWgn/qTF1
         un0fPAuUZTFPrvJCYsWM5WyEUi9pHDy9MSZ728jpGunhXCT4U9TZxZCU7v02B//dQB9p
         nlkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748874886; x=1749479686;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pgdnf+Kl0k261W4dUlc5FhPL/oaQJoIfsI8FOVh0YC8=;
        b=njetmQyfzwiUM3Jpr0GU8yMiPhAEZPATkhooTlhaarOtseol42I48hEn0KgEpqISfU
         hrR+j3EfGLBNtqujKF/WUMfEl3QfqgZMeeyNT7MFirpv9rc4VLLSxyuFlsB8TZyucwKA
         +wln8IgSsCspzBMzS/jb8sFZM1xTwS2qoV7cAFCuWA0IBS7EIw7UQVTSnneOF1fjKhPI
         YsY8+1dTPu85AiaahdNw+1bU88e6C3JPCxSS+2CAVuvCg5SV7AszcmXdyva9OpxXA89M
         QxoszZ4vSQ0d6nfjijAWqVwesoI7bT2HAeU+qyYsyP/5yqyXMjKn8YGlYd8HAh52qxU2
         wfJA==
X-Forwarded-Encrypted: i=1; AJvYcCXUnjdbtSfCkmChl+QNXB1DqPxVYzffxvKPmd2Y3NT1XjjFfJae6bC692QwVCH/tOBCoehdzoAfKoMOZstJ@vger.kernel.org
X-Gm-Message-State: AOJu0YznsLjR5GB+KiWVYrrYwQsEvZGMIIIFUhkyEC0l72YxrPWPA+rF
	BFO6SSxSQfIjqXbP0Q6bDpTMXmZw1gtliYFB4xCJ2Nfft7kXRTnMTftluRHCJTRNxZg=
X-Gm-Gg: ASbGnctOoTMmEBG07eT26AdCgOz08lAsgPax0+kzAdNZNMwDeQUrijNSYylT7Kv7R+2
	sBcIFLEQ1Hu7JAic/M+lxvBQEy4NxTJQUjQujrHd1/tNCFHT5ePglx/WdvAoPnpEgIuzZDPOgNs
	665bc1EAXKZrISHBA5PtKeJ4mcUiCUJGmyZtoLdRFCRfUiDI71DWNNn34+ezq3FFbG5dEkBaQ+j
	4y5auYs0FuVVi9Pt6v0bR2cnb7fbNsS6cvkKL4c2kkD8ll8rspAvIfwo99TXKynZWprWKO8XhUW
	d9OBIewQDGvnPVTFl+OeLyixlVQm6Bvy4LefRORlFr1HnchOyIJ4u0gw/zJfLykX
X-Google-Smtp-Source: AGHT+IEvthBFRHddaW3K2mXdzIX7VYIBUSm2BllTAfnnaOLF+1Y43+d/Bez1sdDwoZ02tePXkncx1A==
X-Received: by 2002:a05:6000:220b:b0:3a4:d0c7:312b with SMTP id ffacd0b85a97d-3a4f7a35918mr10387574f8f.26.1748874886061;
        Mon, 02 Jun 2025 07:34:46 -0700 (PDT)
Received: from [10.100.51.26] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe5b92bsm14885092f8f.9.2025.06.02.07.34.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 07:34:45 -0700 (PDT)
Message-ID: <458901be-1da8-4987-9c72-5aa3da6db15e@suse.com>
Date: Mon, 2 Jun 2025 16:34:45 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, Valentin Schneider <vschneid@redhat.com>
From: Petr Pavlu <petr.pavlu@suse.com>
Subject: [GIT PULL] Modules changes for v6.16-rc1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The following changes since commit 82f2b0b97b36ee3fcddf0f0780a9a0825d52fec3:

  Linux 6.15-rc6 (2025-05-11 14:54:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git/ tags/modules-6.16-rc1

for you to fetch changes up to a0b018a495a3f68693e45ab570fae8191d907d86:

  module: Remove outdated comment about text_size (2025-05-18 13:56:22 +0200)

----------------------------------------------------------------
Modules changes for 6.16-rc1

- Make .static_call_sites in modules read-only after init

  The .static_call_sites sections in modules have been made read-only after
  init to avoid any (non-)accidental modifications, similarly to how they
  are read-only after init in vmlinux.

- The rest are minor cleanups.

The changes have been on linux-next for 2 months, with the exception of the
last comment-only cleanup.

As discussed previously, we rotate module maintainership among its
co-maintainers every 6 months. Daniel Gomez is next in line and he will
send the next pull request for the modules.

----------------------------------------------------------------
Petr Pavlu (3):
      module: Constify parameters of module_enforce_rwx_sections()
      module: Add a separate function to mark sections as read-only after init
      module: Make .static_call_sites read-only after init

Valentin Schneider (1):
      module: Remove outdated comment about text_size

 kernel/module/internal.h   |  7 +++++--
 kernel/module/main.c       | 27 +++++++-------------------
 kernel/module/strict_rwx.c | 47 ++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 57 insertions(+), 24 deletions(-)
