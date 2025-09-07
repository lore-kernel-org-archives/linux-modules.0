Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ED51EC006;
	Sun,  7 Sep 2025 14:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757254087; cv=none; b=lvZLZzhJxNpryC94nzi37+lKHL0GJMyNhvtsFrAw36V0zL/cm32ydimGbH1nCioF04cCe+2iH9J6IwXA1jIvU+uT8EYRjDiF6IX8Ai1ScTzrCjSr1T9Au+1KrBuk4ktyfnsPvj8/jIfOfDwuEXryIHOTmGZ4B8sjv0r55tm5+Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757254087; c=relaxed/simple;
	bh=CewlAPVf5rwZipLs+79xKOiJolW0afmYbnDQyItpV3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FRhrPYvAelcxYRBltGnIinaya7NcGwuDeoGbE3XMXR7WcSP8r24r8qIPvFNJv2o0uoumGpS/r6ARWNAPUvnfmQmt3e22qJXa/8e4+pJcqeLCtfZlT+X4K4VE9J86cWcxYcC83neuIql1yNcoeFEcg9HpAPw0nco0knVluJ9Og6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFWFXYx6; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFWFXYx6"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3d1bf79d7acso2029127f8f.0;
        Sun, 07 Sep 2025 07:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757254084; x=1757858884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GxAmU9TqY2ttRrCopFYc9eGLYqcFkJIuRB66F7nXl3k=;
        b=LFWFXYx6GcvtjMy5tVu9H6N1FxEaD89JcDSRdMfn7R0IjvHtH0H5Xa2ofjqwCvR/Pf
         mxy+pRGzw7qSEIW2NvDA1a8gPDNgrcjUaidkJSG9ejjptpOHZXFpiStgW21t6zKUTDzW
         fiSvx6RHHU+T0J5KAJ+NcDxht+jrpNqqAULDTBcHYSFrnfDmiwWH4opyenajMkrAYg0S
         dQUOJVr8FO4WqDEJLqCoSWyWzZMz58Gkh9SYC/bmGVVG/AGLVmvTfFDs4mM8PTG7c+xU
         Pzj41SS0F1cD8p33CbOlP/qucov3O3M9ZUBVLs9cnuzVDLF2rVSwBY5rd7vbdttdi66P
         twrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757254084; x=1757858884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GxAmU9TqY2ttRrCopFYc9eGLYqcFkJIuRB66F7nXl3k=;
        b=ajYdZunbcAccvJC7fNSxuqRrRsfI3fSaMlox29QHrrzYUM2D94i4Pe6/YL1BCh9h7n
         uBnmiMAZszMV8AhRYVJuL4+X8e3y1TVLSk7rlQTGM2Xy+AzlCMJHCLBCIz2baR1o2ecC
         kHL1rutXBP5IvDLiWy2fspmJYMUXrlJECEQyru5vl/3umvmLr/gjRzve0/RVKJ0Z12Md
         e93nUKJCcAAF7o8/leOREMLecJEca4crw3An2wQZWQXL4BAKegA3hJIj0vtza0TDZUkO
         O0We+x2IY421FoGce4pX9VODWOJcBkqFcedX1cdCNx1rSHH0Rs62ieKko9ZzxQi0pVc6
         /NEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXC/eWmdrPZXo5tNW/52bKB1Vd2k6976+s4j/hrVFPYDwiw/Sy3bpz/Uesq0ypitiiY+olIuekhlgwdz7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzly+4NeJ9M3XnBUrzfKyZRT3jA4pXlSfjqEzW/B4dwKqpeePs1
	HOLshTj/2iqZmbychXtpmUTyXYo6Bn2Gsqb6IMWEyBapHy1kbA15vaLMqm4n1ZKEwAt1Ug==
X-Gm-Gg: ASbGnctNpUFjhsrf80eqjReKLAMPjMMq3RqRD2r1jbpHhfPPNeVCWIna/nznjbI3pGL
	VVbjsATGODQalhkx4GwUI80/56GSMew1qpu6amfVlYgOavI+aMfmAj2T9LIaYTfpITBUpDLOKre
	dWJ6TJF7HobqiN6Ui1DCHNuC6pOcVUtdP7X8JX/UCIkMwF1+3Lpy1wDy7nwupsVWigSca+Hxkox
	z/2AXJCC9IeYTke4Wcveu3x3q0EB53c72DaDeZfSiJJhK9iK8ZKiaKfJ8qxCLNebJo6lso8Xx1d
	8q+O3IDOuu9aCoPZGcsvy6J2qAP/u3W4RA/jlQ8vgqx3yotm5eIL7s1mwtOFsed99ddwvmU7js4
	DcrBMs1VTlnm0Js3jbgANk2+x/LEqtg==
X-Google-Smtp-Source: AGHT+IFaaftWLneymBKhflFTwylgH+pvzeB3ExO1AzrQbwqkvN0CF0Fml/68bb0R5PmjwKXvBaVPwg==
X-Received: by 2002:a05:6000:24ca:b0:3e3:5b4:dc27 with SMTP id ffacd0b85a97d-3e64c3ad7e4mr3695450f8f.47.1757254083914;
        Sun, 07 Sep 2025 07:08:03 -0700 (PDT)
Received: from Al-Qamar ([2a00:f29:1147:fe84:f87a:5ec2:b4ab:d537])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e748aa8104sm663215f8f.40.2025.09.07.07.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 07:08:03 -0700 (PDT)
From: Fidal Palamparambil <rootuserhere@gmail.com>
To: linux-modules@vger.kernel.org
Cc: mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	linux-kernel@vger.kernel.org,
	Fidal palamparambil <rootuserhere@gmail.com>
Subject: [PATCH] Fixed the build warning in init_trace_printk_function_export():
Date: Sun,  7 Sep 2025 18:07:55 +0400
Message-ID: <20250907140755.529-1-rootuserhere@gmail.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fidal palamparambil <rootuserhere@gmail.com>

Changed int ret to struct dentry *dentry

Changed if (ret) to if (IS_ERR_OR_NULL(dentry))

Fixed memory leak in hold_module_trace_bprintk_format():

Added proper cleanup when fmt allocation fails

Set tb_fmt = NULL after freeing to prevent dangling pointers

Fixed NULL pointer dereference in t_show():

Added if (!fmt || !*fmt) check before dereferencing

Simplified the string iteration loop

Added NULL check in trace_is_tracepoint_string():

Added if (!str) check to prevent NULL pointer dereference

Fixed type safety in t_show():

Changed *(unsigned long *)fmt to (unsigned long)fmt for correct pointer casting

Fixed function signature in ftrace_formats_open():

Changed struct file *file to const struct file *file for consistency

Signed-off-by: Fidal palamparambil <rootuserhere@gmail.com>
---
 kernel/trace/trace_printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_printk.c b/kernel/trace/trace_printk.c
index 665effbf50ae..060bd2c35a7d 100644
--- a/kernel/trace/trace_printk.c
+++ b/kernel/trace/trace_printk.c
@@ -363,7 +363,7 @@ static const struct seq_operations show_format_seq_ops = {
 };
 
 static int
-ftrace_formats_open(struct inode *inode, struct file *file)
+ftrace_formats_open(struct inode *inode, const struct file *file)
 {
 	int ret;
 
-- 
2.50.1.windows.1

