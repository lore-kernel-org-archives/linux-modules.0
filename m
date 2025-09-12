Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02503258EC1
	for <linux-modules@vger.kernel.org>; Fri, 12 Sep 2025 23:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757718599; cv=none; b=spGtY5uEHO5zydvx17DTyWaqn6rNVCWcXl7uEP4wAvDp30ulJX4YsL3DBDNpiXZh9KT+owFcG6+l3rklpEQsYcfwzlFCXLRjs8vX0y3K7BoWQx7Nnc2hlDvGiceRgR2H4oxWzPmjKr2vUhiZu7WSGq9VFlRbr+BaYzvbcHXQTkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757718599; c=relaxed/simple;
	bh=wk+cDFX3JYEG9AqRvbMYfzyBlK7TsevKhe8uR7IxhbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oPObGMJU4KC6xEz+ueReBcN75NDPDhFv+frE5IS3YZa7nSONXYB5+DSKHGmAwtP8ypQb3w+sGV1MPGtAc15WdxzL2W0YUsMOZnzXkNurOGR26AT0Dq9e9B2s8BryRYv5FYrD4QCP3wgTUO8G2C6aKmViNyESc3FpPpp6yL/j20o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oSfxH+7I; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oSfxH+7I"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32ddfe3c8ccso2377706a91.3
        for <linux-modules@vger.kernel.org>; Fri, 12 Sep 2025 16:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757718597; x=1758323397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8EcyIGZa+6ToxzyxPuYk0yjX8tMoF6H8xGiBH9NLpZE=;
        b=oSfxH+7IGNGd4n6yensMZUHuSbXJ85ZRxqQ6AIN4hRhTUgIhz3PWx6rIbKq8FlOwB0
         3VWJmMPXWDRI1BumxDz7UkuPKrdNol6M3Psrloco6IzdRdHGtbh6SSD+cRFp9SaK2ejq
         q/Yl9ueMaqDzQbOVM/wBXwa88RixXeI0ZAGJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757718597; x=1758323397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8EcyIGZa+6ToxzyxPuYk0yjX8tMoF6H8xGiBH9NLpZE=;
        b=rxNrOfKgaR8+cf2uEFeyHboi2ATv7Oiema6GoVTECzM6Ye/35jfWZ32k+9CclUuIuz
         e4WuFRgV/XZ1ppKWdOyhOMDLeDwSGiHtkBBzpdUNTxB+gqqaiZmcij8H3o5aC5UvcR6d
         M8fWLNdZ05SLaJKrJWxRvjNjfu8VDasQxuMyTkS9ATm/FZ/raxZNS8yd00VCrjb7cXCQ
         eCEQoIeCUB+heuXShQHzFsbgTM99CCm6fM0bJOZ/rYZJosbthRYdlxiPLHKb7q/wdr4Q
         C+NtIfcesadqKPaeC8YirKN6QLY9TnO6yLga4ADS68zxxdlbcMQguF3RcA5LIiVilKQJ
         +MhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQYh5H/ec8upMR/yZ06ovl3fMsUqszcQYVmpl0jED3/zY6qT5XSSpn0d89bPmuZX7hcLaloQsdyZOAWEXI@vger.kernel.org
X-Gm-Message-State: AOJu0YxwVrLKdf5JCf21PUAMZrzuLlWuHSw9nsJoKeQRciWIhZvvG7RT
	uDMieBZQADcIVEtPl/8BNWEp2IKbV4AqDcrR6D82d6RFjgfjDTa3AvVus30DbLVSow==
X-Gm-Gg: ASbGnctL8Tx/hJtrzteopmvS5JIs16qVMBHxDSuDjFE8UOyCRYQBhtXFv9nDRF4U1/b
	bXAou/C54u71vVjzO3xotKPhDnImEc6VV9QdhMTsEhe1MrB2TpP2lNIv1T+ZIksZ5arkQe9R6zp
	6bdAb0wbKT/uf7Hlqb1tYdIxNcgXPI6UIl/jeK82y35Pe60DlK/1xV3n/xLlGjTCwJ3qg+0Pb5M
	fuzEq7qRPjC1LLEyKyGcm0AQh0/DqXSKInhf5FI6AjK3FP62SyjL3oUJnqJm2EzISXEKmQFbprX
	R9YcZKaBIencsfv0tOF7DlPBxP8rKImfKUx2NhlB3O+xnCRQoOalLGJwvR7AfhnQBGqRtU0J4ma
	bPY45vrkHsAUHKhjjAQiSfO8y1fjbdaR4ZDWghakD1UgvPQ1yaGnbICL2ZUo=
X-Google-Smtp-Source: AGHT+IF2cmiYrFQ1xKWdEqefxU7NdVKHQQ304cYE/Le3s9iB7z7uuIXrlH2bNcZ2AM03GLoo+rEoOg==
X-Received: by 2002:a17:90a:fc4d:b0:329:e729:b2a1 with SMTP id 98e67ed59e1d1-32de4fa1c8bmr5042000a91.35.1757718597437;
        Fri, 12 Sep 2025 16:09:57 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:e464:c3f:39d8:1bab])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-32dea223ddasm1310790a91.2.2025.09.12.16.09.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 16:09:56 -0700 (PDT)
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
Subject: [PATCH 3/4] um: Select PCI_DOMAINS_GENERIC
Date: Fri, 12 Sep 2025 15:59:34 -0700
Message-ID: <20250912230208.967129-4-briannorris@chromium.org>
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

This is useful especially for KUnit tests, where we may want to
dynamically add/remove PCI domains.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 arch/um/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 9083bfdb7735..7fccd63c3229 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -38,6 +38,7 @@ config UML
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_SYSCALL_TRACEPOINTS
 	select THREAD_INFO_IN_TASK
+	select PCI_DOMAINS_GENERIC if PCI
 
 config MMU
 	bool
-- 
2.51.0.384.g4c02a37b29-goog

