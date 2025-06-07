Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE182F3E
	for <linux-modules@vger.kernel.org>; Sat,  7 Jun 2025 16:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749313281; cv=none; b=DhKQYUurcOYDQCGDzhB5p2klH6OHvCojlLKHOnXZf2+1SORQQAF5KexhS3UWKqZ84/UsNi2VNp79O5SsbJcc3SpbYvS1l0WgynfVQKJN0cvcTMBYnNiWK+B2Oqpv1YQdB6nbR8jau6T9g+8eqLs1blPyZBuo1PGfu/v15ohWKRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749313281; c=relaxed/simple;
	bh=B9B8CL00f5okZzseXePU8fDMvR6p/T1oTFKZDQLR6dw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B86rhnLOdSEcTLT651aIKQcr+8ANvlsp3HDhfwi/l7gmMOSoBglNPc1qLzZd8Ox2BhKj9keTWCXiOQrSxQEQxjV3bFgHm+vXozHDAXYpBdNPwQcGSxfMoi7k/BeCqkBdeKg+ybXqb6DjKfnsbIxXGLrBLUhMgr54t5SReDWQBs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=I49aWw+F; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="I49aWw+F"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-451dbe494d6so37562555e9.1
        for <linux-modules@vger.kernel.org>; Sat, 07 Jun 2025 09:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749313277; x=1749918077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E4rQelngGKehQALYMiJrfMrYjtUVNtoEIJLttLq/RFs=;
        b=I49aWw+FUyQah5BlokoW8IQjH/fTLcf5bFz5vPmItcvjJMFG0Apsl9tpSdq3i9F6wY
         c6DftSp8HXcZh00pyuk+WqV+KS9p7aUhO4eEFVBR4+sUR16g60kHJ+eROXWwe43KN9j9
         PEow/x6h1f3pl7AxhXH8AcvGdF+GqFqXG2+5iqv8Lhw4t08sCa6gbmqSv0w6vpaOC3ZS
         BtCn8vUVTByKKs/qrGoIPNkWwsmZfH55ws6ugVL18FnjUM8YRCpzx2FMlyYwpJegz3gr
         pcM7bUQ/rxLSAI57F2fBRZhpbhNhFpX12PmRQDx/xtuso533l9P2mlWpBRTXQaUWTg8q
         4Y9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749313277; x=1749918077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E4rQelngGKehQALYMiJrfMrYjtUVNtoEIJLttLq/RFs=;
        b=TA61NvySrihnxVy7YqDIIEu5YMNz3YEravMjJ1fYAQq9Ks8ZlxlkstvnRh1+dAyRfA
         mxRHuM06X/79ADRCgQVzXke3Q2p3MCcThxPzH9NKyL6A4wfi09cbdsopTAUgAeQwaSm+
         P5QfWlYTYXYRz20LUdgZfRwn5maTkcQfMFdHUEwo4qVMFLQEHyt2+sVAoFowo+MVUeJ2
         DViYn9K6eJndS8/xMuB223GH9bOgsPfSEaU+9kSL3uNhkODVU/4HeBgyWcRO6COO+GHS
         jjK4PKjTIvfiu95bym2B0XRDy2hWeVnh4DvKVpo37+UNos7OUAybF/4EWg+Dr5Wnaf3r
         T1WQ==
X-Gm-Message-State: AOJu0Yxw5WnEpLeUnEMoOiwzSrkUhXjhqtpd4n6O+lYF6mI9Rg/bKgBj
	Dr2fR8XTevW60UQ/cUwndJ/9DC0/4T98ZSrS6zwblku1UwSZKsTXD1nZ4x8nGoKTR0c=
X-Gm-Gg: ASbGncurnlFiBQNXl0XzWK7+4qQhV3mdLMyE8n7d0GKYD5IPTdQU3RIQ1bUH0WZMYgz
	VmoDxnyx4VbCfM9TawT9N4+xTx/LyTh+UIKaF0LusG94gnGPZYdAiBwOAhdohSccuVSJ/qi/l14
	AhiEuPshKFEpP54bg87uevLM+3k5GBSiRN8vhY/9+TZMwe5v6r0XTQT+Wiwf9rJuCxP10H2s6Fm
	vY5Jl5WAaMDT7pVDeZbNj35pvWbczcWsjlcEYrkiMSgy34ENE8ylUUCZEenm0w+p4CQ2Z0NKE05
	5s9qcjFXiuO5/FLoMN7IDxLaPQtdcxpa6d6t702qxAX848RW3nK1vQc6PzYSen0dVs5UQQlUNz9
	ierLAlw==
X-Google-Smtp-Source: AGHT+IEMUd1rojejMaAVMOnFhwaC8vasaKBxpW0zK+VFaSmb4+qfkjNz3jQgXGGgXstDEhktYuTK/w==
X-Received: by 2002:a05:6000:2913:b0:3a3:5ae4:6e81 with SMTP id ffacd0b85a97d-3a5319b1941mr5726232f8f.8.1749313276676;
        Sat, 07 Jun 2025 09:21:16 -0700 (PDT)
Received: from zovi.suse.cz (109-81-1-248.rct.o2.cz. [109.81.1.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5324364f1sm5088096f8f.58.2025.06.07.09.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jun 2025 09:21:16 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>
Cc: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] module: Fix memory deallocation on error path in move_module()
Date: Sat,  7 Jun 2025 18:16:26 +0200
Message-ID: <20250607161823.409691-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch is an actual fix. The second patch is a minor related
cleanup.

Petr Pavlu (2):
  module: Fix memory deallocation on error path in move_module()
  module: Avoid unnecessary return value initialization in move_module()

 kernel/module/main.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)


base-commit: bdc7f8c5adad50dad2ec762e317f8b212f5782ac
-- 
2.49.0

