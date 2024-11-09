Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208C91537C9
	for <linux-modules@vger.kernel.org>; Sat,  9 Nov 2024 16:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731170599; cv=none; b=JIczkRCNEcvA2RJxASXuiDf4mvxG+D47jcV96ngsKrqb9uXCkHjEtfdgiax+PmUHapDGnHwCedTOr/rMJ8Y/VlngM+VTpXCmqAdMg/QOVJAnQN5EVGbmWvvWFFyaoUwDTr3Be6objMg1dbpJlquGZtBz9wR3EFC+4XczmVfEd8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731170599; c=relaxed/simple;
	bh=2Qp1HJqt1ZkkVbLZBqVG7b1YcQk5xk99M+jagErontM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pkfG5AGeFcYggYbZOKrAPfYP1bcvB40aM9yZBzPHu8TsdP3ulXXx17lSJ3DoPnF0seNzuZ/PYusePVvlPS7m9vj/T268fZhUTzXJar08u/28wfnJQ1YlCwWwybBFJJb8tMjQ53rzM+YrwvmYOYl/szm7WmibMPg+adS9mSuX6Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ek3FqsZ5; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ek3FqsZ5"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c9c28c1e63so3976074a12.0
        for <linux-modules@vger.kernel.org>; Sat, 09 Nov 2024 08:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731170596; x=1731775396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dtOUB1qrhJ6BZVMlrSnOsiJoY3zuyj+h662J62NlIZ8=;
        b=Ek3FqsZ5jJcwWqUpbyiq0jFl8dBlq4vqQn0aNZ7W/jkd75/p5eO4VT83NDqiU1r3zs
         zY+jarO47Budbi+MBfxZdwWK95rEJPcW6Nstb+7wvtxRhPo2LDC+CUslgAHNwh7/LaRF
         8wxpwvN3eMMC5mRMTopKlDiPR9CjerFu8Q7AEnBzptnTP5k7JxaCRLjl54V/FB7MYyH0
         2eg6FazvTd7GA+jAlhkgHvsD4dAbB/N86udxq7INDhz3tecCaeGJdn5gXge47+r5VB5Q
         x7ZN/hnc7uTfRUGgvjpbJu51C1bOpZXehxJ4gIy3X9I+6dYT7uMqlNpiD7D+oa3sl7kK
         P4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731170596; x=1731775396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dtOUB1qrhJ6BZVMlrSnOsiJoY3zuyj+h662J62NlIZ8=;
        b=g9zyWKOhMr8Ij79LGfObVKR+FmbycD3x7D1NNbTc1K9KiBujkRdDpKCMFt6cEad7Wk
         oHPHpeF4hCjI/zAOe02rmlt8fieyPAPFfg763hv+wGcwpaMh4QIQevcsBA9iAPIMB+id
         0/WHnM57Mx/hRhwOVbjvg9L8qZ0DPBM72rJNRx4z0/H9IqypGCpVNMYtt6WDtLxwvLmG
         6kWPLKGxw4HtWcuSiBNIA2EnROVCu7jmzx7DUPubMU4hSUqskIdXpXNtgfmj2kFFA5RH
         9jk62VPQx0ps2ECLB10/V7LN0VGV1KT/zFkvPeh4zJdKdrJXj4NJlBv2GcyjTAKtdQqF
         GWgA==
X-Forwarded-Encrypted: i=1; AJvYcCU8yAGei6uRvDAEM74nBmQQgwy8npwuLWYrCc0uEkwVviZ4h9FAYCi9R3jxKq0hRsmdaft/W1OyaI3q2xja@vger.kernel.org
X-Gm-Message-State: AOJu0YxkroWZ5Aiya5+s0aUJoV6SRpW8NOc5YFSytdm4dVqLqGFQh97v
	tCTbQfpGHoXrfjj7vmqZm3i2ZgqRPaZkaoiNrN+aYBpJc+vxksB5aFi5wucS
X-Google-Smtp-Source: AGHT+IH7231OePa+yBIz8tJ6e8/vCYdJGujtm+Z+3fug9+EiKytdXj3vtfiLhgsQw3QuCZaUbGJIeA==
X-Received: by 2002:a05:6402:254a:b0:5ce:aec7:8802 with SMTP id 4fb4d7f45d1cf-5cf0a30b295mr6109540a12.7.1731170596261;
        Sat, 09 Nov 2024 08:43:16 -0800 (PST)
Received: from localhost.localdomain ([2a02:3035:a05:3bf:6eb7:59e0:a3c6:6ba1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03c4ef98sm3139226a12.68.2024.11.09.08.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 08:43:15 -0800 (PST)
From: Sedat Dilek <sedat.dilek@gmail.com>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>,
	Emil Velikov <emil.l.velikov@gmail.com>,
	linux-modules@vger.kernel.org
Cc: Sedat Dilek <sedat.dilek@gmail.com>
Subject: [kmod] README: List strip CLI command option for summary
Date: Sat,  9 Nov 2024 17:42:46 +0100
Message-ID: <20241109164311.20632-1-sedat.dilek@gmail.com>
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

