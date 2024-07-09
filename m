Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55BA29CEA
	for <linux-modules@vger.kernel.org>; Tue,  9 Jul 2024 04:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720500497; cv=none; b=gcZZ9T4C3e+wy+1Cqxo/x7fZFWlo61Y+ixS1K/MRAee2W/W5Do8YEb0nhZGYOgg6IW+qdariyZyF5U2Ymfw+llZDeksmJAquzDUripnxEAynG+OgYbaQexnrUWC8KlZ4AKmYmD6+2AcruAUXuVhkfvUMiitIkuqNI8z/8l0ANN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720500497; c=relaxed/simple;
	bh=NnZw40sQXELEWUG1Es/sP9T0EhYs+02Ost1cP2lkOwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r5hxzfZTyAWSZpPYezbjCCQdw0AA+lNd6+POWxIRrpkniLVRY1QHpomDNXQIWhajfoy8JdzsJr2srNq/uaCKlE54vGjYOIFy6THzgNMlimyZoARDKNNyJWVoKVPmxxZrfDOuFRdCUseIzoIrZFQg/sLySU7lvJJCcF8vGkNl/Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0EJXrdf; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0EJXrdf"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-48fdf2d5309so1560542137.1
        for <linux-modules@vger.kernel.org>; Mon, 08 Jul 2024 21:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720500494; x=1721105294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aS8206+pdJ+YgftDfckLVV2trZR3QFzBB2VzVDfLGXE=;
        b=h0EJXrdfYi1gxCZC/3SlVVNKzSeJbKTD7mdWvpepMUJ4ZRmOVSQqbPRH2/j5ElYhNP
         +4Pgco4MeuSaI3sTxRJG3lGtqpIj06zitcPUcbAA7v9VedASbmqZbs+2+gYIPbVqzIwu
         kicciTpPLnIFD2tGiTRzODQZZpF1tk2M02Swjqsng3Ix8MGXqiy5MBpqOpHvINWWcbTc
         k2w6oBUwpilApnDPw2H4bXHyTne/kw5JGne2jyYMlJ99xK/ZldY829908cSIR6I4BrfL
         1uYRhu8+WpBnSPzimEtVj3YdCmPNLvjbiuEcU/Fqvjfb3eJXWk5y0rIZpMXrPntB0pNF
         W0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720500494; x=1721105294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aS8206+pdJ+YgftDfckLVV2trZR3QFzBB2VzVDfLGXE=;
        b=SvKggKFWpcpsQ7b7xv70RIi5qaeCp3b5nMigaZMU401oJBicACO5nxAVcXK08uaLbz
         Bl1ULJAa+xDXNSyzMbBtnqz0RdsrKNoncmlDD1PzRtrwnkwIpXMPvh/VywIS2hhRlGOf
         q0lj7XM3jQRpAYjG/sTnO0VSYeOsw/afSb9w08ci80FvcXuT+V8fj/8MN164+fKQ0zUx
         xSmTTngux8ooWqCSPh8lNX8rOQf4OkZoT5OxD76vDY8TCIz6IWSfcuaWLmUde3eO7AfP
         0pWgrs/zjFqv0k2lSUlW/88B43Jjss51idg1te5vdYFff6RiFfzskKlqI3hX+JaDJeJ8
         uJuw==
X-Gm-Message-State: AOJu0YzvYdkvrzfWiymZmLDdmK3Vu+FSPX1fQd8cUPBelz0XnbbwIXwx
	ddnzSt183F17M/tU8Jrh6+unnpVpLwGqtwAoznGJo8OhDQKdFgKk84KnUw==
X-Google-Smtp-Source: AGHT+IFN+T0qBM9TvHYrisnq+fpdXH1fcJnywKRcGPc2KYXsFhGA2O18YPs/sseuxIgt2cUSWoSnew==
X-Received: by 2002:a05:6102:d8a:b0:48f:eb4a:b0a2 with SMTP id ada2fe7eead31-4903211bb7emr1507032137.8.1720500493869;
        Mon, 08 Jul 2024 21:48:13 -0700 (PDT)
Received: from ldmartin-desk2.intel.com ([2600:1702:4eb6:3000::3f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f1902ac2esm58639985a.59.2024.07.08.21.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 21:48:12 -0700 (PDT)
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH 2/3] build: Add mod-weakdep.c to EXTRA_DIST
Date: Mon,  8 Jul 2024 23:47:57 -0500
Message-ID: <20240709044758.67725-3-lucas.de.marchi@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709044758.67725-1-lucas.de.marchi@gmail.com>
References: <20240709044758.67725-1-lucas.de.marchi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix distcheck failure:
	make[5]: *** No rule to make target
	'/home/runner/work/kmod/kmod/build/kmod-32/_build/sub/testsuite/module-playground/mod-weakdep.o',
	needed by
	'/home/runner/work/kmod/kmod/build/kmod-32/_build/sub/testsuite/module-playground/'.
	Stop.

Signed-off-by: Lucas De Marchi <lucas.de.marchi@gmail.com>
---
 Makefile.am | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile.am b/Makefile.am
index 4b67ee2..847c8d3 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -221,6 +221,7 @@ EXTRA_DIST += \
 	testsuite/module-playground/mod-simple-i386.ko \
 	testsuite/module-playground/mod-simple-sparc64.ko \
 	testsuite/module-playground/mod-simple-x86_64.ko \
+	testsuite/module-playground/mod-weakdep.c \
 	testsuite/module-playground/README
 
 check_LTLIBRARIES = $(TESTSUITE_OVERRIDE_LIBS)
-- 
2.45.2

