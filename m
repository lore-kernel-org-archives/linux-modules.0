Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BEA25FA0A
	for <linux-modules@vger.kernel.org>; Fri, 12 Sep 2025 23:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757718601; cv=none; b=bPrfzWs/EpnIDhEq+iKgGeFXFlKOn2j1NUc+ZNYPrR0oBSUDbg393f+51Ojds/+yMXH/eIwIx9nvstRVWr5C3pAgq8FP/FACDUCM5cVf0oah3couqPwNbrWgZSVvtQJygf/O9b7hA+sbO33/vHUZczeBRYGq3RI2gCTAw/8sRpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757718601; c=relaxed/simple;
	bh=YEh//s+EtsJjGeLO13TxNSxxYq8mSsN2ket2o0T8fSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZFNHfEcMAdzEb8SR0i9XzqTEwG/ZZRxwDMyfSZsQaPxBJusF4FeagvtxzjRse4PUgyMRhVZZkGjtXv5huGiGrOlfGOXYokXjlu21UuKihFVY3Prw71+nVIFQB0VQSFu58Iymjn4Dkblus1tGfJwpQReX7tOhivm8JXWy6lvNm5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KQRUMNRz; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KQRUMNRz"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-32dd4fa054bso1995451a91.1
        for <linux-modules@vger.kernel.org>; Fri, 12 Sep 2025 16:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757718599; x=1758323399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1aqQsfYpqczFMN6xd995B9cIuPxzc6IeMNO1DIuGzJc=;
        b=KQRUMNRzLQIwOB9SGgCZ1b7r6/r4gdYltSkJpKKYpVE0gy/yOkd/lgR2sxXv0RsNZs
         bb1tIWazv+Bj/yXnD8NLciEBJU/5oUttJVhftH88p4beIUfOkrE+fCxcM1ez6l63Qa0y
         NgQA7SH+iE4cEOkAMfz/iB2jsQ9aTcB8BQbYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757718599; x=1758323399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1aqQsfYpqczFMN6xd995B9cIuPxzc6IeMNO1DIuGzJc=;
        b=o4pS8w+tB5VDzHZZSPw2YrHTtOkR6PVGMmcJBlkjiTIbPyFGFwJ8D9JbosC4aXrDOQ
         DPZQDacxd4q/FqATIiNoqPJplPO7ntkbWCUTtJsV1VAn9C1+xzw2/OllY6C3u5cMomAU
         xb8fEMFTa1xQNHkTwrxiUYYqNoIBVENxDtQYxhMX84yeyGdxwzaxgaWwTywNoUzkthAM
         Oi7x1J7D06bthw4cotd6xGB29+m3r0Q253Gwxf6sLTDh1aomFkAh0q5RihS9nZX5Qxnb
         pp+Px3QJwqlPoA5+fwwZKSb7xjMniS7AbDzWP0B/NgDYeEY44OBJQI3t6OlWG/b37fIA
         3LPg==
X-Forwarded-Encrypted: i=1; AJvYcCW7bZxiJy0CLcnwpg2LLAMWp5WeFm4yRGgy/uO92MKc4mdihBydyYJEyXk8kkIkVYNr8gv5sP6YcHpA6MGD@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+QURB1v3leJZ0a8RjZMXCjAtjcFwIZDXBD6ikNhQ3jjzzr+pm
	04yT85PZYr2KGJWn/M8VcAT9HawdATFcyaSx4t257yLDRkmMV4YleomaPmCnDECd9g==
X-Gm-Gg: ASbGncvmv1AemUZY7JJWQmY6hqWhXoQ5415WiEv2OQcmKEymZ5hdH5Q4bp8TClNNXF2
	B6vMyn7PfgiCA5N4+b/RAIoJ7VapdhK0s02mCd8aNLpnOtYAA2Z9+m6N40g/h5/ay/r4A5ED2Po
	X557gE8nzFrnsXct3qNacNXJ/vAEJDIDsB1Ii9xi1m0pLlzl6SwifIquoKCihbeXbvh+wZP+b9b
	1ZkaZr+HfWPM0cJVrUgUVUoFA9xAze5yYWc92tFHMk3Qoee+IQ+q0/aKj35bj4WIBI0qyBOYeY6
	QHxPTL7upcVAN0e7t7ETcs19MrRZy6upCLNR7IMXBMksxIM+g78mOUadwbamtHEd+w8W7WeVQEX
	DO/jvn3W3jUYLHsgjJJc5zw2NCnnLaW7ya/ukaO+m6336DihG/GnfLO6a65Y=
X-Google-Smtp-Source: AGHT+IHahHShoB5Ii1WzvFIbd2LUrSYt+MXYAQPhHq31+WasztFuE5rlFSFzEb7dWV7UvuA2EIiQ1Q==
X-Received: by 2002:a17:90b:4d0e:b0:327:53f0:6368 with SMTP id 98e67ed59e1d1-32de4b88595mr5567635a91.2.1757718599221;
        Fri, 12 Sep 2025 16:09:59 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:e464:c3f:39d8:1bab])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b54a35b7e31sm5643608a12.11.2025.09.12.16.09.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 16:09:58 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>
Cc: linux-pci@vger.kernel.org,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Sami Tolvanen <samitolvanen@google.com>,
	Richard Weinberger <richard@nod.at>,
	Wei Liu <wei.liu@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	kunit-dev@googlegroups.com,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	linux-um@lists.infradead.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 4/4] kunit: qemu_configs: Add PCI to arm, arm64
Date: Fri, 12 Sep 2025 15:59:35 -0700
Message-ID: <20250912230208.967129-5-briannorris@chromium.org>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
In-Reply-To: <20250912230208.967129-1-briannorris@chromium.org>
References: <20250912230208.967129-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To get some more test coverage on PCI tests.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 tools/testing/kunit/qemu_configs/arm.py   | 1 +
 tools/testing/kunit/qemu_configs/arm64.py | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/testing/kunit/qemu_configs/arm.py b/tools/testing/kunit/qemu_configs/arm.py
index db2160200566..101d67e5157c 100644
--- a/tools/testing/kunit/qemu_configs/arm.py
+++ b/tools/testing/kunit/qemu_configs/arm.py
@@ -3,6 +3,7 @@ from ..qemu_config import QemuArchParams
 QEMU_ARCH = QemuArchParams(linux_arch='arm',
 			   kconfig='''
 CONFIG_ARCH_VIRT=y
+CONFIG_PCI=y
 CONFIG_SERIAL_AMBA_PL010=y
 CONFIG_SERIAL_AMBA_PL010_CONSOLE=y
 CONFIG_SERIAL_AMBA_PL011=y
diff --git a/tools/testing/kunit/qemu_configs/arm64.py b/tools/testing/kunit/qemu_configs/arm64.py
index 5c44d3a87e6d..ba2b4e660ba7 100644
--- a/tools/testing/kunit/qemu_configs/arm64.py
+++ b/tools/testing/kunit/qemu_configs/arm64.py
@@ -2,6 +2,7 @@ from ..qemu_config import QemuArchParams
 
 QEMU_ARCH = QemuArchParams(linux_arch='arm64',
 			   kconfig='''
+CONFIG_PCI=y
 CONFIG_SERIAL_AMBA_PL010=y
 CONFIG_SERIAL_AMBA_PL010_CONSOLE=y
 CONFIG_SERIAL_AMBA_PL011=y
-- 
2.51.0.384.g4c02a37b29-goog

