Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E1C13AA2B
	for <linux-modules@vger.kernel.org>; Wed, 23 Oct 2024 20:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729716846; cv=none; b=Ghje99my3OH1jQ+eGl0WYA4aS8N+4wyFNWMWDHiynusb7pUQyCgR1ifHPVRN0Ai33yCepaZYi0QP/clEwOLBfogzqb1IIx2/KAVnzEGAonKi6I+IusHMIvRROLi7lffgurKJwZaHj/MgzAn4GEA44pHBBM2IC/h3wTk6iCPhqoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729716846; c=relaxed/simple;
	bh=g5ckEO23Wn5YIEXbTRJcK4k8xpMQsQkgzw7p8a9MqaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E7mrOqanJqW9h74bnVsTrGUbGBRmzuJq7oKwA0botD8X7oy/VHPODOA+4hXbRICOsGPKuACTr+0E+DSWUt1ICdDHu7pvWo2RlNeOpi2BaIVI/AMzlteyjV5qE3JjwQjLNo54eoYX14jPPv9sEU88bAR7dw9tENOwH0K1skBN+oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXImqc1O; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXImqc1O"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5cb15b84544so235915a12.2
        for <linux-modules@vger.kernel.org>; Wed, 23 Oct 2024 13:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729716843; x=1730321643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ORBQL0Yg2MeD8szwBEe4qZP77M4FRJlxDCLTMnnCgEk=;
        b=BXImqc1OfaI/VLgN1P+cMYXP7tPg+NoOQnQ+kUt0uUbia/AvgH+AFPjdvmRLRxGSQq
         svIRBYCktxhDRZJMOT8FWB7ClVCEIUM+KAsN1WCkeCK6IdPMo0RRGZ+t6S2n9LxByxra
         +Jk4cnEslZxpXKngBSTykoRTa+RxdtkgJsXkomzcjLcXU7LtBbqBXfqeLj6My+0QwbiJ
         4J6ePZceo9oB3Z3bLxQ6KfuPXXmwqKop72P8VOBmDIBmBWR2tFN7xFc/8Jr68ueNaRIi
         2+nJirRjBnNLX1RsYkpCWuFPPgPG5egcQhSzMwqvLFlbN/7c6TliDQi1O771o+twDmdg
         TiuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729716843; x=1730321643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ORBQL0Yg2MeD8szwBEe4qZP77M4FRJlxDCLTMnnCgEk=;
        b=IJoPwrNzRwU2AZQFiIxZvzpUVhf+6timLfifyHFkYzBUlltZcsDim3XgnJTBB3A4Hw
         +RGpMEg4K4yfVG1CcVTLggSwkkKDuFUyUQp4I3LXFFr3mscBIa5zDQiYiq/ootnk4G+t
         f4DJw4xyN2ySFHN3AeCbfAE2bnhNb8O1gdqOOL3Ut4BPTaZvqAGtti8bxQ5+tIq40wRi
         gcKiP2qf882GYwjfhKsHnsf6Ld41pJmIrnkXPzcY4sjltPB9SEzA8+G4PFni0ZbDlalk
         mEamkogK+6LhoihCJ+duDkpCY2i9Bi4IVKYW0I8enYwnVJYgffdypNhoP7QxWp+HsuvN
         xWzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgkPDZENMKS3x+IRywMk24YjC+e2bNsTKbroiFicg29vW7ICjN677xRajlTuz8xdDqM/NscveApWT3oHvF@vger.kernel.org
X-Gm-Message-State: AOJu0YzSsqWQCUsc60dCoOhbhIyqzwf/GkbV9/tD/oSBgRANHrVywPj3
	iSOL1goZnYmyJZeZgqWLVnfM0IY+4j9Q9zrCGP/gR6L8T79rbNEH4hsM6X3v
X-Google-Smtp-Source: AGHT+IFlqgRofLjWLWamsYT+EJlNuWJj/vbdLnyicBfMgntkOzoURWwA4pJfnXUDgRAvBeBJR7DZIQ==
X-Received: by 2002:a05:6402:3888:b0:5c9:36c4:cead with SMTP id 4fb4d7f45d1cf-5cb8b26f218mr2615871a12.34.1729716843068;
        Wed, 23 Oct 2024 13:54:03 -0700 (PDT)
Received: from localhost.localdomain ([2a02:3035:a06:45ec:3047:d021:9cb4:a37e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c6b556sm4806894a12.63.2024.10.23.13.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 13:54:02 -0700 (PDT)
From: Sedat Dilek <sedat.dilek@gmail.com>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>,
	Emil Velikov <emil.l.velikov@gmail.com>,
	linux-modules@vger.kernel.org
Cc: Sedat Dilek <sedat.dilek@gmail.com>
Subject: [PATCH] meson: Collect all prefix get_option at one place
Date: Wed, 23 Oct 2024 22:52:49 +0200
Message-ID: <20241023205352.45271-1-sedat.dilek@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
---
 meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 58acf2eac8e9..2ed33c28471f 100644
--- a/meson.build
+++ b/meson.build
@@ -187,6 +187,7 @@ sysconfdir = get_option('sysconfdir')
 cdata.set_quoted('SYSCONFDIR', sysconfdir)
 
 bindir = join_paths(get_option('prefix'), get_option('bindir'))
+includedir = join_paths(get_option('prefix'), get_option('includedir'))
 libdir = join_paths(get_option('prefix'), get_option('libdir'))
 
 distconfdir = get_option('distconfdir')
@@ -493,7 +494,7 @@ summary({
   'sysconfdir'  : sysconfdir,
   'distconfdir' : distconfdir,
   'libdir'      : libdir,
-  'includedir'  : join_paths(get_option('prefix'), get_option('includedir')),
+  'includedir'  : includedir,
   'bindir'      : bindir
 }, section : 'Directories')
 
-- 
2.45.2

