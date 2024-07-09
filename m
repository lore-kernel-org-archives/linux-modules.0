Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C4929CEA
	for <linux-modules@vger.kernel.org>; Tue,  9 Jul 2024 04:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720500493; cv=none; b=aypmcD82tiKBgK+3/6/WKViq46xgyv6WPmk6TADl8fPKuZRHnDgunJRQjtaGpXbz2LMjx4aXNir3Zw7/8ZNfL2ybqK8IebAOSB9fP6T33sb8HM5T08kqqpK3l+/et36zEixJ1bqI/BmphLiQpRjzZmPfZyGqT94+W7qH9ZgekFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720500493; c=relaxed/simple;
	bh=RxZLtr692jj5AwES7MRKB8LnWHqjw6F6hLyxioxr6z0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VmfdsCGoI9jnPyvKP6gq6rpfh+DuKdnmvdkNRx0Q0A3URLoRY++klxZQ9qTBDSmpz0hkYfNsRDuZSJXQfm5BO52mzIV6BG8ht098AhlPJJLr0UAf8Xi7rYK3pAFg6OxO92jmrxmnah4VDGz25KD/pT17Akg5Gis0ZqLpJli42gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYT0S6Xq; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYT0S6Xq"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-79f1b569ab7so34287485a.3
        for <linux-modules@vger.kernel.org>; Mon, 08 Jul 2024 21:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720500490; x=1721105290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hVQmzQ5gm1tySs6YGgxwqa2WrwmFGYDtLV0HkkGNAWg=;
        b=fYT0S6XqRceZCXhD7BFVoBDaoV1XJXCPtpeafdUEDzLYB4bBPuMVuyfGa+rvYouquF
         AeFFGkW7NWSoFYOyu5I4/mGH3xI1P9Fov5xwObZM3nvio5ZJ0T6AnakvbpIPj1VM4J3L
         UdJnTp+GgFsqdTPBTcIgpmLcXrwMnlwoxlc4N0y4OGGWbSk/YO5dAv3vjnDD74Ri9kN0
         KVHR4D3XfiUj2Uk5hgGMl7mRiIC788hbsAsb6nRx0PH8OCy2B4xJ6RXIFZ+vj4MIMZZG
         OfMkBYlkVQVtLdsJOw5ZR8GTmPRE1GuBkB+JOJqD38/Is/PLPJtt0IM725pzggAM4TWE
         wI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720500490; x=1721105290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hVQmzQ5gm1tySs6YGgxwqa2WrwmFGYDtLV0HkkGNAWg=;
        b=luBGGcedz9AO1OFvySkeOfJS+ZsmtsspDmJDgi9k7zy6X/tW/EQytlLVVFV5IZBfpo
         RKwQx3SK28HB+E/nc4I1gyURwRS8b4c6qDY0sZbl90jGPfpV5y23jM4SfM/+7DHRcBXx
         rem74JiFBogkYrhArrXfYEoF815Ovp3vLyzAQMDOCx4/G0WznQN/jnxn+FGTU6Dn2bM7
         bL0PVvZGGOJGFyAwfJzq835G0T6cLEZQFFB7008eGl6TXfieQ12nLBNfbrAbWH0NM/AM
         q2te5aLivRr2rx77Ik3NPnCmpl8dLQgNkW6HaTPTWZ5C+4F1dNSh+wk3DeBUBmHHpgUi
         yqWQ==
X-Gm-Message-State: AOJu0Yz6GMHGPI5a0jM4gXgRWsXI1T8XCHZNdkeuUKyBfNH9o4nMUuOe
	AUTitX3Y1r65Iukc6m5CEfxBYh/+MtYeQdJHEQ7vMtdXf+e5ORUfxOE/Wg==
X-Google-Smtp-Source: AGHT+IFUuOd2KcdKUDDoexzMMpMXDdhiQOkNa0UhKXFCTxn9H86ZPIpB8SD/YPeQBwePX7H7qFx/zg==
X-Received: by 2002:a05:620a:137a:b0:79f:4e6:181e with SMTP id af79cd13be357-79f19a44101mr188243285a.13.1720500489662;
        Mon, 08 Jul 2024 21:48:09 -0700 (PDT)
Received: from ldmartin-desk2.intel.com ([2600:1702:4eb6:3000::3f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f1902ac2esm58639985a.59.2024.07.08.21.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 21:48:08 -0700 (PDT)
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH 0/3] Use github-action for CI
Date: Mon,  8 Jul 2024 23:47:55 -0500
Message-ID: <20240709044758.67725-1-lucas.de.marchi@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Besides being in kernel.org, kmod is also hosted in Github
at https://github.com/kmod-project/kmod/. Let's use the quick
integration with github-actions to test we don't keep breaking
build/checks.

Lucas De Marchi (3):
  ci: Add github workflow
  build: Add mod-weakdep.c to EXTRA_DIST
  build/ci: Add distcheck

 .github/workflows/main.yml | 54 ++++++++++++++++++++++++++++++++++++++
 Makefile.am                |  1 +
 2 files changed, 55 insertions(+)
 create mode 100644 .github/workflows/main.yml

-- 
2.45.2

