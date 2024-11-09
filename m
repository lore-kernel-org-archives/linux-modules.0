Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C4E1537C9
	for <linux-modules@vger.kernel.org>; Sat,  9 Nov 2024 16:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731170448; cv=none; b=aCLW/8s5lbM9qEwx731yIwGk8onYx1NdLsZQg6hCeC+hjfCGkz4ktz86yqzEZJvoH93K4M6/i56m7/32h+9VrEvaMCElDkzCDOJ8heFVsL/nC+jfffb2d5H/WrShWQ+AK/nA5vnVkqDkmZFsiBtWUkM7uGqbgOyxxwxtXtPaQek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731170448; c=relaxed/simple;
	bh=2Qp1HJqt1ZkkVbLZBqVG7b1YcQk5xk99M+jagErontM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f0CR4Px9iLRUP4QVBN4WxJDjvwgj5fbubMxrl4uuF2e8fIzgBh6xcy4kkVLyj/RhQnLpBDgKN8O6nC8KpjWLMmfR0fuHgtLyL2781Te9m52if+f/HF1UbNT6AySdsG0BTzZfA/nsXAsJAyjYYH0MQm0PFbT7eRM5U1hvJzdEbWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bkg0g+cJ; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bkg0g+cJ"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c9c28c1ecbso3941100a12.0
        for <linux-modules@vger.kernel.org>; Sat, 09 Nov 2024 08:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731170445; x=1731775245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dtOUB1qrhJ6BZVMlrSnOsiJoY3zuyj+h662J62NlIZ8=;
        b=Bkg0g+cJdmSzO1XSQiTfOGd4BxbcmOwFwO9KHw37Mc5Pbje5eT84NHvx9vC3sAKWZ1
         IAKjn6kEz8DnEKxmnWPxa/XHHhUl74EAMQa9VBn+m9VJAQD8+NLIVKC+eB80Ek9eCsoU
         zVgOEE43Ze1LUUq47qsyDHURqWIRPFUhYFbWvGXFf5A5oIN420UPbN6Hg0VzbmXfglB0
         G4f6FzPjIik1X/GsUf5a9l5MB1g5ZBpfJkKHHOlkLC5XA5kxb9Kjje7fp50RAbsJQ8sw
         fuezAkfNIWD7FByAxocCPbgKwnWaudGnFLGeOLWk4ByusIrsPJ1LDjTpzC166TkxgCSn
         Y1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731170445; x=1731775245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dtOUB1qrhJ6BZVMlrSnOsiJoY3zuyj+h662J62NlIZ8=;
        b=kw1vzBY8PTScMuLkTXXgBzZw+0Y2fpMHnbhRRCm1lask/ZK5SLfozhagMV8hH/GCOs
         9uGj+QvWs5w9te0Nsdepe2jOsHNXHI5vwIUPgmqwyXR9GQ+9ifba+kdJnQVUdqd0FZj6
         QuRF2QG4/oqBpjvTDJa3NwVxv6CdT8feg7jyFy7cL2oyfkSoYxNNFD4KrMrCV+R7YhVX
         B5Zjm1/F90PjRCAoXtukcTgu6UreDF6/ePLTP74Mgq+YG2jVfdlng9GYHXShwhwRQnsz
         YBLsxKkXvPswqq/MDAOyXaPpJdN2GMkDHZb9w7WkJ2O9H0lJ54q4LDF86ZX5gN4F3MQ1
         qFgA==
X-Forwarded-Encrypted: i=1; AJvYcCVKeVYMmtI+SrSSCOZEkHgiRsgwprUn7dbfvKrtBh74BEog+zeWp5T2QKEb76MoGUmgfZCUEJno8ZnaNjoL@vger.kernel.org
X-Gm-Message-State: AOJu0YyFvXhFb6v7jePm0pj4dF1LeflRhGFao0WoZgDry7I3x5GSg6wK
	UPho0Fj+M6yFfc51/D5tgoLCRhwTa7y7B3/2danyH5AWV38acUFXgFx4QN9i
X-Google-Smtp-Source: AGHT+IHLVcNegpdchpBK9ykQlaQriOzfBvfHIO3r8SNvHgNKQKCgXeLisn9qi90ySXhqzglMn2D7CA==
X-Received: by 2002:a17:907:3e9e:b0:a9a:8674:1739 with SMTP id a640c23a62f3a-a9ef0008cf0mr617216766b.53.1731170444940;
        Sat, 09 Nov 2024 08:40:44 -0800 (PST)
Received: from localhost.localdomain ([2a02:3035:a05:3bf:6eb7:59e0:a3c6:6ba1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0defadfsm378508866b.151.2024.11.09.08.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 08:40:44 -0800 (PST)
From: Sedat Dilek <sedat.dilek@gmail.com>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>,
	Emil Velikov <emil.l.velikov@gmail.com>,
	linux-modules@vger.kernel.org
Cc: Sedat Dilek <sedat.dilek@gmail.com>
Subject: [PATCH] README: List strip CLI command option for summary
Date: Sat,  9 Nov 2024 17:38:54 +0100
Message-ID: <20241109164031.20496-1-sedat.dilek@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As addendum to kmod #220 "summary: List buildtype and strip options" [1].

With passing --strip the summary will list:

  User defined options
    buildtype        : release
    strip            : true

For details see the meson CLI command options in [2].

Link: https://github.com/kmod-project/kmod/issues/220 [1]
Link: https://mesonbuild.com/Commands.html [2]
Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
---
 README.md | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/README.md b/README.md
index 5169890a88a9..3c1ddbfb0a39 100644
--- a/README.md
+++ b/README.md
@@ -56,6 +56,10 @@ For end-user and distributions builds, it's recommended to use:
 
     meson setup --buildtype release builddir/
 
+Further binary size can be reduced by using strip CLI command:
+
+     meson setup --buildtype release --strip builddir/
+
 Alternatively you can try autotools build.
 NOTE: The autotools build is slated for removal with kmod v35
 
-- 
2.45.2

