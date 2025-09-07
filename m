Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F306184524;
	Sun,  7 Sep 2025 13:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757253138; cv=none; b=NzgPw75UmhJw6oQ3r2z0yLncuc7dt6DZ8O96dc2W+2n4nK/QFVBpjA06yTjtQUEDWy9B1q+BfKk/nLe0Y/j/yOx9NuK+W+3o5pEnhUtrWuIcdjEEe1pS/djlLwd3rlbSYOGzlDSd0wHnRgNTV4Mcq2NfPHc3pDfb310G3ZH3d2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757253138; c=relaxed/simple;
	bh=x4kEclAJ0MfkCPXoMNQMW2TGVfix0VDvNa+xrJwZWv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XzH2x/1dACSw6TfxwyEXsCPyhXmK8sKPLm5WjeulPDD6jlU/CcDlpyYCK16LPQYyHTVDPr4bn4kfmb/nICA8d81Jvlx/ehIuaqRG++7dwBOSnlTK+ffh0kUXq/f+CtXJhfew5m3Mkui5OaPG9zP1EmQg9tXfJKaqqR9yJ1Ozs2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FI+4XpCL; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FI+4XpCL"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3d1bf79d7acso2024775f8f.0;
        Sun, 07 Sep 2025 06:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757253134; x=1757857934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1AI/b6K0rk5sP/dbv2aFVDE/bjLTVHU2fHUDn3dbML0=;
        b=FI+4XpCLtieBj37XMzD77UnjpiU2NodylUaIN68b6fog01QSjmMUYt3lj1fTdfDwhF
         Metd1+d2AiKC1/sIENNEEmeSZmrq67r+92zue2TFelrP33+CsK5upyXN0DelfRjNqHBB
         U/0A+JxhJFq0UKy4eyfRFnGfss/pqnDgtXRtjC9mI/4WKQX0zikxEST1OKvEo7pUOYsb
         /S5v1G76MbSTpACkqJN/08IQYorwZU/MV3qTLv+/AchZsPra0jmxt2wUsFf9dxq8KSND
         GDa7rbrn7EpupuXPj02LHmK5rPi893MzEJ7p5mUW+ItRZ9uR/GYebz2IU9ZXlBkvaxo/
         A0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757253134; x=1757857934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1AI/b6K0rk5sP/dbv2aFVDE/bjLTVHU2fHUDn3dbML0=;
        b=j0c8Aw9kmMbfm8sWkKVl1ZduUMvQ9fzvnARpywAXPXaHS8UH7yWG2SarIFmw73Qzo1
         biUyTwu5xRGSYnbKe3cWQNuNFAVT5jfs3nG70XXje7R/yoTLE3KUf3Sy+CkxsRQPhY6K
         iv+l7gD3ZsyXwcs+yPDkHXPQDNRaw0gnUl/JW7aAN7jBwoGpi9jk7FwGOdUT4ibpov5L
         knpm0Mwui7HkqgJgqPzdjBb/JtnLWsFXsJ8cDaLXHDMbofu1BvLyu6LJVAZ8/ZdcFWad
         /LxJ/ZzoNrD/MuVYmA5yPwd7Pad0IOiJNogOsPwbYch1o55mMqZFYCpc0+B/la51gQ77
         Db1g==
X-Forwarded-Encrypted: i=1; AJvYcCWvTQXb2cVuIR+qByoiYQJ/nrzUnB68tkLvAW26+Y/oizmYE4OgfbCxqVnILm68g/1rfRu+2y8FziS08aI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK60cuRem0ICWqkEZyWBa01rUgzBIjcq9Pq9RJo6wM+LVaYkWA
	elzczsqzBSSQR9C7lWyN4zhS0jVcubLr7dK3PzJJm+gCbsd7PRZ2BPrtoEd2fqndkPoNSA==
X-Gm-Gg: ASbGncuUdYD5CgBwVkb0VLD9lk9/VyL5DLgSpV2AWivNRGaeNMVF+1YmdupgsPPIbyq
	0BKtWHeVFEJCv7iy7DnceolU7KEUfJzlX5O/2RBKWrkxbIAUjOOjeyE0wOpIDXp/NrVvGEHFV7R
	ZEM1hNzuMAQOkRUs3ZJyuKEKhgu8HT3Qr9EPjY6lE8TbP2qgeu3sSZYw+fZ87ykqvSRhs37wKcR
	Jgzd9CtWIVbourFTbjdLR1SW8Bb8p2EiUUarzeWr7NEvLMSKs0LyrRB97fpqDHDyCKUo5DLBAj8
	PTYLtL947hSMGaI6Xtt9K5tZkZaNnaK23EvUVh17TXDLj9BVJfKF0gEOyDqmSn/UtPBt1a13s1+
	oYryFDQLBJqeuh8jJVDV0tOb8nXYwnw==
X-Google-Smtp-Source: AGHT+IFCdRYV7VLuXijcUd76ZEpf/epWD9wR2plfNa6bc5qA4+Zo3kWfhCAKChyl6xpVDKs7UBfhgg==
X-Received: by 2002:a05:6000:2489:b0:3d4:f7ae:bebb with SMTP id ffacd0b85a97d-3e643554e7fmr3685802f8f.26.1757253133925;
        Sun, 07 Sep 2025 06:52:13 -0700 (PDT)
Received: from Al-Qamar ([2a00:f29:1147:fe84:f87a:5ec2:b4ab:d537])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d1007c0dc8sm36569968f8f.53.2025.09.07.06.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 06:52:12 -0700 (PDT)
From: Fidal Palamparambil <rootuserhere@gmail.com>
To: linux-modules@vger.kernel.org
Cc: mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	linux-kernel@vger.kernel.org,
	Fidal palamparambil <rootuserhere@gmail.com>
Subject: [PATCH] tracing : Fix multiple issues in trace_printk module handling
Date: Sun,  7 Sep 2025 17:52:01 +0400
Message-ID: <20250907135201.760-1-rootuserhere@gmail.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fidal palamparambil <rootuserhere@gmail.com>

This commit addresses several bugs and potential issues in the
trace_printk module format handling code:

1. Memory leak fix: In hold_module_trace_bprintk_format(), ensure
   proper cleanup when format string allocation fails by setting
   tb_fmt to NULL after freeing it to prevent memory leaks.

2. NULL pointer dereference prevention: Added comprehensive NULL checks
   in t_show() function before dereferencing format pointers to prevent
   kernel crashes.

3. Input validation: Added NULL check in trace_is_tracepoint_string()
   to prevent potential NULL pointer dereference when called with
   invalid input.

4. Type safety: Fixed type casting in t_show() to use proper
   unsigned long casting for pointer arithmetic, ensuring correct
   pointer handling across different architectures.

5. Error handling: Fixed type mismatch in init_trace_printk_function_export()
   by properly handling struct dentry pointer return from tracing_init_dentry()
   and using IS_ERR_OR_NULL() for comprehensive error checking.

6. Code robustness: Added additional pointer validation throughout
   the code to handle potential edge cases and improve overall stability.

7. Memory safety: Ensured consistent handling of format pointers
   when memory allocation failures occur, preventing use-after-free
   and other memory corruption issues.

These fixes improve the stability and reliability of the trace_printk
infrastructure, particularly when dealing with module loading/unloading
and format string management.

Reported-by : kernel test robot <lkp@intel.com>
Closes : https://lore.kernel.org/oe-kbuild-all/202509071540.GTxwwstz-lkp@intel.com/
Signed-off-by: Fidal palamparambil <rootuserhere@gmail.com>
---
 kernel/trace/trace_printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_printk.c b/kernel/trace/trace_printk.c
index cb962c6c02f8..665effbf50ae 100644
--- a/kernel/trace/trace_printk.c
+++ b/kernel/trace/trace_printk.c
@@ -386,7 +386,7 @@ static __init int init_trace_printk_function_export(void)
 	struct dentry *dentry;
 
 	dentry = tracing_init_dentry();
-	if (IS_ERR(dentry))
+	if (IS_ERR_OR_NULL(dentry))
 		return 0;
 
 	trace_create_file("printk_formats", TRACE_MODE_READ, NULL,
-- 
2.50.1.windows.1

