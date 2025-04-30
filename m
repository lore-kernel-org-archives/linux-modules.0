Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D59825A33A
	for <linux-modules@vger.kernel.org>; Wed, 30 Apr 2025 13:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746018736; cv=none; b=HDiXN9FgduXDPiSXrzyzZvWLz5ek/l/SdIw2y1XQKjxCxcTr3S5x0Y6JT1AvQMw3ftLM8JRQ3m1EbLgZp5tvMt+MbzlIrK8xckEeQPPvwRXf3d6kwR3O8Ls3ryAZJvxHE8awtyZhQ9DGgstUjGrOcVQkWsTjmF4VhNKLKgPq298=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746018736; c=relaxed/simple;
	bh=PIY85mKxHJ+UI+JYvM5nYj4nxGSfQYk+edb5eO6mGwU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=sNmgEe3ZV/E2e9oNlvbQwa82R/DFLhXANfmVUJwIiRr9bpU6C5qXIfsWkNFpqIXtlT1UpWTm4yPZrNOP9TF60wi56NxB/zqVE+TKLVPJLXJZR+RZLpldu8FD43/R/0MA0p9paxJLn6qXc3ZwP38qg0KRgDIrdY/vMxnD7M9794E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FpV+rXuV; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FpV+rXuV"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5f4d0da2d2cso13958201a12.3
        for <linux-modules@vger.kernel.org>; Wed, 30 Apr 2025 06:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746018732; x=1746623532; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjL1WsPsnsYmnWqXBUM0+iVtLhuhJsfn7GTamqYJHzY=;
        b=FpV+rXuVxEMyAIOv39lSq7WdWHbFs4cs34XtDbuohYbR6saOIG4TafjT5egHC74Og4
         kd0WoyTRilVQ0KAT+YwxB5JippkGc6cM6VSZsaumsHMZl3df7ctthoAPhcDatqldJZDt
         8qWJ8Bv3U++Iw/gjaPplZuM4SvhtkfSUtieOb53ya3b19YEgtYLGFCgto4IwTfi+U6Vp
         qDIkpJnY/XzxAoh00KE5U31j/gZ2iiDJ7Or16vE9MThCvnB0VkRjBqXz/vy0KKDagwDV
         jVrMCzMhNTVK/lN+65UEZAjs7LeNSEfG09P7TTfeg7jfSurbBD/iJLs2rptCpYqsBy6i
         8phg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746018732; x=1746623532;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wjL1WsPsnsYmnWqXBUM0+iVtLhuhJsfn7GTamqYJHzY=;
        b=uAcYpszMU87jBMXnoQ9aEoQmrz4A20J6Qd9ITXj8hFaCfw+Sz2et0wa23fQdTaWwDi
         XKRkv8Q15kSLHmTsrDAGcCFo5z5uAthsfVxE4sZJhTLgGtA8Pl5BQXusNoI2vrbzGQZO
         Vvql6DnWwaW3vyJZzHvMLOcssKl5UUQUu8bDR9i8t46itukVuY12YTGAyCyS8DOMV2nq
         iZkrBlNhkXEAqM4ybxw/rVzGJjqTlgRAF8yBwh/zsDqosRGV7r95JbuC4hLcP6fWrqVo
         Bv9nq56GTAl0mZU7/q5o3xz100SKmKxkWqIJXCnw1Y7RVCN9ZSfiRMCqSKMBe27ty3bN
         mNWw==
X-Forwarded-Encrypted: i=1; AJvYcCWs8hG0le5zJni6MmzebsvDdaMG0BFVsr/bcPpPyr+Fj5IyanaW4zCWAEJKjK0KJRMKNZcbMkIFDC9UPC3O@vger.kernel.org
X-Gm-Message-State: AOJu0YyzGud5n3S6kC6rCaMQ0+288OEAg6clR5OD0CMwuSH990sf/cN+
	gx2uwEK8m3XkeKIqGZV4VoIpnt6rC3W8zYjQvN2q4LKar6Cb5Q84xPkNGF4Ne8g=
X-Gm-Gg: ASbGnctM1IzP8LX4v5XVfy4g8MPiPezdpTliKUslJxuOj+6SkzwPlvEYxRtNPDGvZFN
	tKBBO82KqnML4gcnGTWiU9Jvb8qPjSnV1FpsJL3xFAbBOrvWpKc/K6RWE4PIguj+r7c2al13tsI
	VkEjQvONdrzlJfuXxd9cwDrzhuO+YNz1849Y/gILKX17ChkVpuNkd0B6eztWaHfQzKhDAzCmFj7
	6D0k5Vzpc7STgYPgUFTvtIye6pbRreCb+gWFfgRj3ky4IxhTn0jreIr7TUClOJbHDuNR2L4c69w
	CNroRKDLjZGx7OWYLfZMLizDKI0k8aF4cyLlIdQA76wEGZtyu5P1sw==
X-Google-Smtp-Source: AGHT+IETi/U1rnwgErZQDP2Zc6pA5YllvKPlYnjKU6evHX11NFKR9wcmYXjnkl4EVs84aMfZNsIkIA==
X-Received: by 2002:a17:907:969f:b0:ace:3f00:25f5 with SMTP id a640c23a62f3a-acee21567bemr247077866b.2.1746018732276;
        Wed, 30 Apr 2025 06:12:12 -0700 (PDT)
Received: from [10.100.51.48] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6ed6af86sm926769066b.133.2025.04.30.06.12.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 06:12:11 -0700 (PDT)
Message-ID: <223a3bc5-0696-4547-b6ca-ab6882510259@suse.com>
Date: Wed, 30 Apr 2025 15:12:11 +0200
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
 linux-kernel@vger.kernel.org, Shyam Saini <shyamsaini@linux.microsoft.com>
From: Petr Pavlu <petr.pavlu@suse.com>
Subject: [GIT PULL] Modules fixes for v6.15-rc5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The following changes since commit 8ffd015db85fea3e15a77027fda6c02ced4d2444:

  Linux 6.15-rc2 (2025-04-13 11:54:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git/ tags/modules-6.15-rc5

for you to fetch changes up to f95bbfe18512c5c018720468959edac056a17196:

  drivers: base: handle module_kobject creation (2025-04-16 15:10:55 +0200)

----------------------------------------------------------------
Modules fixes for v6.15-rc5

A single series is present to properly handle the module_kobject creation.
It fixes a problem with missing /sys/module/<module>/drivers for built-in
modules.

The fix has been on linux-next for two weeks with no reported issues.

----------------------------------------------------------------
Shyam Saini (4):
      kernel: param: rename locate_module_kobject
      kernel: refactor lookup_or_create_module_kobject()
      kernel: globalize lookup_or_create_module_kobject()
      drivers: base: handle module_kobject creation

 drivers/base/module.c  | 13 +++++--------
 include/linux/module.h |  2 ++
 kernel/params.c        | 47 ++++++++++++++++++++++-------------------------
 3 files changed, 29 insertions(+), 33 deletions(-)
