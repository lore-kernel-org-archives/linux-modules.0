Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B06413C3F5
	for <linux-modules@vger.kernel.org>; Tue, 23 Jul 2024 18:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721761174; cv=none; b=ZNE9gEhN/W/xJpmBpcfunVdIuOxg4L4p9FEwgJ6xB50tPTPysmYlsyOybj3QUhyLXSRgrEVhZ9yzexS8j+wpNrJi7J7JpK850YO7wLYp/dgi3/9tMhlh4+yH7Y86Bp7fYxlhFMrjLHGwqf28K/etVx0AAUA9QIED6Tdxdqdw82Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721761174; c=relaxed/simple;
	bh=IsXB1Qc8UFjCfMJQ8BAMVqq+VaMyNU/uP8bq0nXf+Gw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nu5kOvxMnQQyvqhkVdQ0ovsYUBmvHtk2PvMmMinysr6okG5Jn4CyglrmqtyJmetxBet8viSnD44dIPpxe0FKO/1dsZOub+Z2lrPkwCqLtYgpW1NPDonzukfi4M7bms7dwFHTTgQRiEQAIY3uV1hwCn9r5xzUrZ7VXY7V7AgKtZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+xUqDVe; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+xUqDVe"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3dab349467dso3323763b6e.1
        for <linux-modules@vger.kernel.org>; Tue, 23 Jul 2024 11:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721761171; x=1722365971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lw4e0uNRauhojJazJsnDArYyXjPgv9Ss+pX6xQZNVIE=;
        b=Z+xUqDVeXksIwyazTzJkSz3q53zwd0FB+hahDDtxuhRH/Qh105zW79C0lsX/b6ghRw
         d7XVRvz3LtQ3taBPjT8igUe3IXbaFgrUOD4Rv27aoBxUvnZBdPxRtFgxkwUe5WZlcHQA
         4T+KOiMfnuLZl0SJV+BJ8x2+5vFr344LC7yS3L7t19hwz4aRFFYOwvdhCzPIr7UC7ery
         +WEyntZ/wWRBeBeNPraMlNlvc7GplXp4aMaoYLR1Nv9ecT2T/3VHMssQCpXgR3jelJBx
         +Fn2QSkpmJvmyWgZrotDtYnyilBe85aUTd86ESg0D9UKJsTEm5lrh2jlA2F/n7JDgyvy
         0Atg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721761171; x=1722365971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lw4e0uNRauhojJazJsnDArYyXjPgv9Ss+pX6xQZNVIE=;
        b=JyyVQb9sD/sYoBi6EE51yZS8A50hTe4Z7boP+QR2iWFJhsSIy7Bgx0drZs7Wz6yXdJ
         vFq+a4youM3QaXZ4KqOa5n8q4YCPYnv9oKgd8UpCeAe2/M/6W4euoZCctgECOFkO9IX3
         L9SQ24DDuCi3Cxl1R75W3ilZ6uD3J15XOSSs3tqZDLugqyjxD+XXJXC7oMas9uSDC8hm
         NZrvj1qn/CuefmBwxSvX4D/Jy5JFCNahipDH4Y9h8tvV8yvhCGdn/YuFRaYhka60kxlw
         DUmsWQ6ckH4pwDg+akpSbQucW50EVJUxJj0CJ8ww91WQmEg6K5vNTCQ6++2DFn72F6+w
         GPeQ==
X-Gm-Message-State: AOJu0YwAvco6qKEl11Y43IPZtvJQu3oetWIpGNMpg6o0NFCcde2coIRj
	KBBE5Tp3XtKLI+J4cbFH4EKL2n/Rmm/vzVTp60aBATOZtCWu71/SQqMLrw==
X-Google-Smtp-Source: AGHT+IHxDj8WBBpYBnNXqWToBMTnmKo2ESn9JhKmU2anW1jirPWaeWePGJIW1hY3jXAsYOp1SSWpEQ==
X-Received: by 2002:a05:6870:c0c9:b0:261:26ab:f89d with SMTP id 586e51a60fabf-26126ac08ffmr10398235fac.48.1721761170872;
        Tue, 23 Jul 2024 11:59:30 -0700 (PDT)
Received: from ldmartin-desk2.lan ([134.134.137.74])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1990792a0sm504967685a.109.2024.07.23.11.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 11:59:29 -0700 (PDT)
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules@vger.kernel.org
Cc: emil.l.velikov@gmail.com,
	Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH v2 0/3] Use SPDX
Date: Tue, 23 Jul 2024 13:59:18 -0500
Message-ID: <20240723185921.1005569-1-lucas.de.marchi@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the license notices with one SPDX line, like done in the kernel
and other projects.

Changes from v1:

  - Do not mess with copyright notices, just the license
  - Fix some unintentional move from GPL to LGPL for tools (even though
    LGPL should be preferred so we can easily move code between library
    and tools)
  - Split patches so the removal of one-line source description is not
    bundled in the same patch as the license update

Lucas De Marchi (3):
  Use SPDX header for license
  Drop the one line short description on sources
  depmod: Remove license/copyright from the middle

 libkmod/libkmod-builtin.c     | 16 +------------
 libkmod/libkmod-config.c      | 16 +------------
 libkmod/libkmod-elf.c         | 16 +------------
 libkmod/libkmod-file.c        | 16 +------------
 libkmod/libkmod-index.c       | 16 +------------
 libkmod/libkmod-index.h       | 16 +------------
 libkmod/libkmod-list.c        | 16 +------------
 libkmod/libkmod-module.c      | 16 +------------
 libkmod/libkmod-signature.c   | 16 +------------
 libkmod/libkmod.c             | 16 +------------
 libkmod/libkmod.h             | 16 +------------
 m4/attributes.m4              | 18 ++------------
 m4/features.m4                | 17 +++-----------
 shared/array.c                | 16 +------------
 shared/hash.c                 | 16 +------------
 shared/macro.h                | 16 +------------
 shared/scratchbuf.c           | 16 +------------
 shared/strbuf.c               | 16 +------------
 shared/util.c                 | 16 +------------
 shell-completion/bash/kmod    | 16 +------------
 testsuite/delete_module.c     | 14 +----------
 testsuite/init_module.c       | 14 +----------
 testsuite/path.c              | 14 +----------
 testsuite/test-array.c        | 14 +----------
 testsuite/test-blacklist.c    | 14 +----------
 testsuite/test-dependencies.c | 14 +----------
 testsuite/test-depmod.c       | 14 +----------
 testsuite/test-hash.c         | 14 +----------
 testsuite/test-init.c         | 14 +----------
 testsuite/test-initstate.c    | 14 +----------
 testsuite/test-list.c         | 14 +----------
 testsuite/test-loaded.c       | 14 +----------
 testsuite/test-modinfo.c      | 14 +----------
 testsuite/test-modprobe.c     | 14 +----------
 testsuite/test-new-module.c   | 14 +----------
 testsuite/test-scratchbuf.c   | 14 +----------
 testsuite/test-strbuf.c       | 14 +----------
 testsuite/test-testsuite.c    | 14 +----------
 testsuite/test-user.c         | 14 +----------
 testsuite/test-util.c         | 14 +----------
 testsuite/testsuite.c         | 14 +----------
 testsuite/testsuite.h         | 14 +----------
 testsuite/uname.c             | 14 +----------
 tools/depmod.c                | 44 +++--------------------------------
 tools/insmod.c                | 16 +------------
 tools/kmod.c                  | 16 +------------
 tools/kmod.h                  | 16 +------------
 tools/log.c                   | 16 +------------
 tools/log.h                   | 16 +------------
 tools/lsmod.c                 | 16 +------------
 tools/modinfo.c               | 14 +----------
 tools/modprobe.c              | 14 +----------
 tools/rmmod.c                 | 14 +----------
 tools/static-nodes.c          | 14 +----------
 54 files changed, 59 insertions(+), 782 deletions(-)

-- 
2.45.2

