Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F55F1EA7DB
	for <linux-modules@vger.kernel.org>; Sat, 29 Nov 2025 19:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764445988; cv=none; b=Y0FrPVRIh0TsMXbcGBQ42/fPEeNG4OEc5yEF7nD5o8vmFfOOMCxpHPG0Jv4irUPBBPZu65mgljj5aEh0fDfXlI48QKznzMqbd+UCVVbE4sQsyzRbYyHu16VzruybixPcE/t/T/nLd8tnUm9YSbppw/BAM9we4LL8mrCLAENn8wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764445988; c=relaxed/simple;
	bh=UYASUc3+cc9N6xfCjk2IMzWPz7jySHVohyawDKdKyww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uYGAC0BFkcMSvFWT+FKoe0jEyv6OtrBBtm2R8i0aMvXoj+FqgR12SqLK8ntZ2n9jog5vJeqkU9gP1ZMoU3W0ihdU1KlXI+HJnvuATCP8xOiJpkVdwQa7BLfWzoFdfw3ktNfGVBuMsunhU7P966mndWjl/CNdjP+vtpZ/10GEhn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ill1EMR6; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ill1EMR6"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6420c0cf4abso2707232d50.1
        for <linux-modules@vger.kernel.org>; Sat, 29 Nov 2025 11:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764445985; x=1765050785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bq5yUqUCzfdjLEn9031/L9EMDQ3XGvUTCWlQPofKw7E=;
        b=Ill1EMR6yKc61BY1eVYp3ogR7LmwTIfJH8DSoepqB4ATUWILikHzeZGCLIfTl7jah9
         fmFjk8v6NNPOTvXZ8ywrW/RClnqlcBLVpvkiwGki/r9uYDIKbk1RVWX7agdS1USedzPE
         YKxECNPIpg/8HSMypEKrjZ+I7UJ8Tw/FBVRLa1Y0mkclRpW65sghE+MY+18Gz+MafOoi
         Yemg2c0Rxic2nkArfhEEGwZhadAZ4eTtW2dI8+IBqz0ammUbvROi7zwzhErL9KsE1AW9
         aMHGXTFmLj54nwY68Cun43fHGvHtag5ehAdBxlaNE/mBVbMyl3ZYvIym7ginzRjrhRzY
         jP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764445985; x=1765050785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bq5yUqUCzfdjLEn9031/L9EMDQ3XGvUTCWlQPofKw7E=;
        b=nr6cf6OZBL9AuCgLD2JvFx2p1RGnLM883J011uuRJ+IgRUtcm3MVk7zSuqvP/rH7ak
         ksBXD41VdsA50leVlVzbqDJNFrK5SImcAnNPVaGuzQiSsUKrdswyRCY2esb3OyrZn/Yq
         Grtz1IP8ccBHRs6WFP2pycomwq+82fVZBDLQi8OJayYaED+vAU0cAx0Jt/vIvF4GCx3b
         uT6HyfXTKEen2G8/fucKSwAGJCxWq928N1VJiNgtcsceb2slbbZfOjwKMKnywDr3LNC5
         E6YMAE7y2u74DnqDyo+I0+sHkmcqqBaqV2AyHxZDdqTT/p1U5zrSaRFv2XSqZzwfyuh4
         +pUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDdHWpYXUCnqCPxuieC8XbHHtSlMT47YTrZ4vVGW6DokX01FP5VqSv6A+OnyinBCy43OiNLg9SCTECgFIg@vger.kernel.org
X-Gm-Message-State: AOJu0YyTSKTGtfs1Te7Yh4RNyAAou2EAN9eseA2eeUZffPj/F8H80Lcl
	0xCE1yY6ps4fWASgSQEQzGdNKCviLwHoH+whgzjgXqyV10/yIqKlPDfI
X-Gm-Gg: ASbGnctQ7WWdz9d2JEFRu0uTzT8Pw0vJKjVCoXbB6LRkMpOjADwQKSoTOngqSesLbiS
	cFXo6SFk8F/Z/aYYI7x7cPjyuxJ1RN/yc1tBu6Ho9KDCYDguCTjp3gUtZF9av+BQl2b2zNZ25VW
	xhcJzOFzaXG3Xjm+ql8vS42f/2dVa3+3xtuMxMAXWXAWMtqVa+98EapuAn1y7hnbn1zMuWIUiyR
	eh0oVRw1obZIEwNKyrlyIu3T4sVRylaAQ+Mzwg3YysIrLfjUDfFEbsCrT7vEbX0P54rSC0fpJxS
	zu5v1/SNiMoGC+cBnrWlHxCh1uL3+cNzwGD7x+E2mpwfFh8v/Cgy+CLUxGeUDztbchusvLXs5IY
	PMGAp/AxPWesqpXkE3sua8GY5kWyQVVCMY1eUttX8b89BD67w/5WLgXR9zLEy3zOwSoI3MKVacv
	R5JM3ZPAg=
X-Google-Smtp-Source: AGHT+IEfj6PVUeeY07J7TJfo/pC02NnxeqqVhA9KwWv0e199pnEc7YIXLK9r3fHsMgALzxDeBf1gGQ==
X-Received: by 2002:a05:690e:1510:b0:63f:a8db:47b4 with SMTP id 956f58d0204a3-64302a8f75fmr24324286d50.3.1764445985371;
        Sat, 29 Nov 2025 11:53:05 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:353a:b6ab:d4ee:67b9])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ad1044f9esm28751737b3.56.2025.11.29.11.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 11:53:05 -0800 (PST)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Subject: [PATCH 0/3] Unload linux/kernel.h
Date: Sat, 29 Nov 2025 14:52:59 -0500
Message-ID: <20251129195304.204082-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernel.h hosts declarations that can be placed better.

Yury Norov (NVIDIA) (3):
  kernel.h: drop STACK_MAGIC macro
  kernel.h: move VERIFY_OCTAL_PERMISSIONS() to sysfs.h
  tracing: move tracing declarations from kernel.h to a dedicated header

 MAINTAINERS                       |   1 +
 drivers/gpu/drm/i915/i915_utils.h |   2 +
 include/linux/kernel.h            | 209 +-----------------------------
 include/linux/moduleparam.h       |   2 +-
 include/linux/sysfs.h             |  13 ++
 include/linux/tracing.h           | 203 +++++++++++++++++++++++++++++
 6 files changed, 221 insertions(+), 209 deletions(-)
 create mode 100644 include/linux/tracing.h

-- 
2.43.0

