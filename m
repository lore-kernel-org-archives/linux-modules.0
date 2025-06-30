Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5DD28B7FE
	for <linux-modules@vger.kernel.org>; Mon, 30 Jun 2025 14:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751294175; cv=none; b=UKtlnq1/BL967x4qQC8skVATQfWjdWtbiwMZ9pcIubNBTC1ob6e1X3S6FRlE1sJ6L6XuWRe60RXRLWtmOESlD73ilXN0/6lh1eNeLwDjyg/Tf7rwrl1XQMrQiERHflbB8Q52lmZ/8LZ3CCvYuxMyc0AIxf3fWud5A4UgtLmhUiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751294175; c=relaxed/simple;
	bh=ijmcaIoa3T+v1e2tSEIgWQRy27wlu82NxAcWi7tyNVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s7VnxERMXKQ++UJToz9bZS9Xxqo5fw8TUizt6cTgZnWZP+5HaBtLtR8nAxzGJbCE+Y2mx2Cq6FBNMemiJKFlr8jTfe3HsOJwocEAakeIgy/cRAmeu6Gg9HImjTtdlWsVEnNn587gSdq+dpTT2bU23kA2fE8ZDDEnLUqQEFigo18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KNf3ykGG; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KNf3ykGG"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-450cf0120cdso22556105e9.2
        for <linux-modules@vger.kernel.org>; Mon, 30 Jun 2025 07:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751294171; x=1751898971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yrJ26ovUMBn5wPlmSYUHRqvSgt1eO3iWTStApxaLMIE=;
        b=KNf3ykGGMUGqTEfmMNqWc/Pg+V2g20cXO0Ux0R7q/JiV8yVqNfDLt9XIAQw+zqSfCU
         tU0p1QDmUeJhoPTxlzALjMqJSYlYk5HiuDQau2MHnzRfxIdIeI8ZInEcjS2n6WpHN+Jw
         MSH7k2kpJdNEISWkG/poRVqNZPXoofGgxWiWMViEsR1vGw11StkNga1p3AT1bIi97pG4
         t5Ft2SA8aYdM7G8DRTtk96Hm5/sbiDcbtkvoEFxa+P4NNBzTqcuQugjPWIcqFn+zZd7c
         y4kW262o6qtpSEcNMEks0z3IMd17zVwXQNvp5AkLGAwXT466NccH/d6U9Jccs/iG4szB
         WA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751294171; x=1751898971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yrJ26ovUMBn5wPlmSYUHRqvSgt1eO3iWTStApxaLMIE=;
        b=bMs13NiqGs7VHWfU92+SilLYQR/Ip9104fEO11HhugqLQm3fta8Iyvaj9jpY5XcHpa
         PXWvEV8yrHTmH7DvoookfTBbD2qqq/ne36+h0Fh5pia5wi7G6ktbscJSWmK8TfY+clTa
         zxZUXxN8P2TsqDYF5icuM2arwveHyPQ0Yvyl7BdRa93QbRqYSmSrAXxhOHc0we98ugTe
         c34QVcJ3sFcldRfSNtrI4SN5K1qbe7MwvaQktvL2vnbErfOTxxH8C8o6KX1n69Xwob1R
         HeZgU8KrIoqCm1niUAQCHButdjhsKtd/jnwFgpjG6qkaATR4tI2wAwCXbLrOvfOw9GKh
         mosw==
X-Gm-Message-State: AOJu0YyBwmpCoUUKoxP8WAKlX8RlL/4q/5M9svlocNPKDsIEUgl8V/qy
	2khnYFgTC08MBpPdhQcqCCP7ndO23CsM9BVouqCP0iyfGHkYvd6R+PHCNU18OAJSTD9ue+q4dUD
	2PAn1qwE=
X-Gm-Gg: ASbGncuhCaA4Aiagq9r9/E1vf9CHg+PulCMiuQ1WB3EzwCHuEqNwu1oq7iCo7yhOTpo
	l29/2+EX/tG9nh8JJi3khjG6wkekUM7I6DHBnAM4vgroC8E+FH9zSx/wgOHNumGK12TN137f6RO
	S0mAYqvt6KhFbwDgBvDtMGAVKT2le0v2kEraW5qdGZbthdQFegwJUxPPDa8lOWUyOQvJIuJunE+
	2fs2DXgV/LQ30MTGfKvmQDsoznPAbM5N9+7XKWiORYTxirxyTt+w+1pq/XQ1T27L7LEur7ZJ61o
	RcQApEiwsbsIo8GZ1Ogs0YoZmyx0zmMoOaeokZoNXE//PCSy81LcA16IUTzekA==
X-Google-Smtp-Source: AGHT+IHmF91CXXbMG1elqcOHyJHe0oSVxoNF5JEELyTlvftZNeN1Qp2AI1Kgqc2JrBLSS9DwFOwyMw==
X-Received: by 2002:a05:6000:2d81:b0:3a4:cfbf:51ae with SMTP id ffacd0b85a97d-3a8f435e16dmr8103859f8f.4.1751294171089;
        Mon, 30 Jun 2025 07:36:11 -0700 (PDT)
Received: from zovi.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a4064b1sm139691695e9.29.2025.06.30.07.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 07:36:10 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>
Cc: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] module: Fix minor problems related to MODULE_NAME_LEN
Date: Mon, 30 Jun 2025 16:32:31 +0200
Message-ID: <20250630143535.267745-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a few minor problems related to MODULE_NAME_LEN and
MAX_PARAM_PREFIX_LEN, and clean up their usage.

Petr Pavlu (5):
  module: Prevent silent truncation of module name in delete_module(2)
  module: Remove unnecessary +1 from last_unloaded_module::name size
  module: Restore the moduleparam prefix length check
  tracing: Replace MAX_PARAM_PREFIX_LEN with MODULE_NAME_LEN
  module: Rename MAX_PARAM_PREFIX_LEN to __MODULE_NAME_LEN

 include/linux/module.h      |  2 +-
 include/linux/moduleparam.h | 15 +++++++++------
 kernel/module/main.c        | 12 +++++++-----
 kernel/trace/trace.c        |  2 +-
 4 files changed, 18 insertions(+), 13 deletions(-)


base-commit: d0b3b7b22dfa1f4b515fd3a295b3fd958f9e81af
-- 
2.49.0

