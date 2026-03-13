Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB473313E00
	for <linux-modules@vger.kernel.org>; Fri, 13 Mar 2026 13:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773409788; cv=none; b=HdkzsLrGgOMEgeSJWOa4y5u2rHmdtCYpDwRr4fnBKqwtP14Z44ruS5BqMjY9hq/YJoj2nxlQAQ7sDyShWKSfHwitKeiQ9BJ0+n8mjVtNkKTlaOR3bla0uUCJ+z3z+bgK2IleyHNu2fUmPkWTM5n/5w3CRiYSzLYbBQMUu5euHfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773409788; c=relaxed/simple;
	bh=YnMpR5lPf3jSw6eLZ2NQ2f7yK7YQfgoM19JHXNaU8t0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mtBbKV7SMaH/YlTJWy5fPR+i/r7AbRAJ4lc8plBo23UzXwbhI49LveG7+XBS3x4ZkDmsTozlnWpnQ22DwHOg3NLQXMzLNgoo888wPRsgbcEFIdSh6mtXUNROa1AVIKJ5k8rT879SGb3hKqLO3C11TSVJHCQ8W7/ewzfZE1hJfwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CHJCCrhW; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CHJCCrhW"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48534b59cf3so19714055e9.2
        for <linux-modules@vger.kernel.org>; Fri, 13 Mar 2026 06:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773409785; x=1774014585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OsPkNs24DyC+gYfgTurZrSgEcJz7fKbx1x9/mf6V/yY=;
        b=CHJCCrhWr9o+Ul9M/PQqTCw13cGwo5x0ij+zq5fpiLtvHxY3+l6ywUQqC4RobF2bwY
         VqScN1GMmesrsGZHS7kznPZt2Sj1E1u3PFovoxcnUjS6U+uNqqo/ppvH9yYLFrzeQ4uK
         6zsVgdZnJKSRFpD8TsmBB02rmnpIh6HXQye+/lvn9uSL+JFpxDrZiZJUOpunVU1yZNn1
         5HweSkc42Kj/d41M95OKA+NeAGkYGFOmmCj5QJEZ2JSAXW8VeRFASvthu+RMffrCZMBk
         B1Ri0PXUk3/DGZrglQKXHH/Zf0owc50UhW4GlqBGopgcAg8xs6EA+R39l540SAtcW94A
         ovrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773409785; x=1774014585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OsPkNs24DyC+gYfgTurZrSgEcJz7fKbx1x9/mf6V/yY=;
        b=hN7sjK9hK5auRIjjdcQuZbxVAYRJIC7lz9nIvmjsLHcMbr8F68qWTutP003VCjrMdc
         ODTOwJBnluMNYM4M03UVf3/yYwEHCDnwv40z1Q72slQ1dTUXcP/jnaBntkb+0/04jxMp
         XlFSRzBtfaiR81jBXzLYIStGJbYNSXqcEFp2McpJZRz4wm6AJv6qPTdZdv7aMvAe/nIs
         POAGUKrfrOmKs46KNDXeKOVp1eD3fzxF5ba/g1HQs2qErENidh1elDzGoIzDnG6H8IeM
         KYe06gcCa8YIcwar6J7MIHtanNNiGudNXj58/3m7ZnHWmE1sFjmNmGsALWOkAamfuTkt
         FsYg==
X-Forwarded-Encrypted: i=1; AJvYcCWF08G245M7n/WVhidQcc06FuDIDCQ3ELlOZsU0Kqk9U+wqBMgTzRcRtAd4OIihuJpSF3hyOoyrHy35881x@vger.kernel.org
X-Gm-Message-State: AOJu0YyHk0MPKlX6VEOPd8dk8YaZOgmrYXuXsw49pipGvU4O1BEWs/LG
	vgvf7SfuIMF+x+7gvA0YOoS3trXi1C0rsLcEh8RDYDtazvYVdvTMCW5wiVnuplclU1M=
X-Gm-Gg: ATEYQzzMS4Xga4bBJNGUDQAhxGwmm1P1Hrchri6GpBttq+sY7ZBp5RTFWTiK19X409x
	6rqmNk/D2NJZ/f9vhRMnyDRNVrdm5nlTASY1WeyLsC4DfzdTzja9pNs01hOQ7et4IqGGGMB8usE
	sl8mXcW/xDiOq8wRRVz5ji3Of4LwUm4cFjS/C0d+09eZtMXTF0rD/sZ+6CNVVQK/L7zgRFZE4uW
	y5rcRJ0svZwQmPGl6cMNG5nq3BB3fp/E4bIuWmsqXvoWjv1wn+eD8XSFm+3XbMKndlcZ3wbLA1+
	SgmiGBoCt3G70FFKiysjfdfVGU4HzHi71dkxYMhUUsZroPSBKDIC9uNc7pXRY7mk+8R3KlYNKSt
	SFzsKQXyz/GcdI6gHkprUkIe5KuLZdVPM8eGqXFp7QyYDdygfacmp++XUiK/kUVHu6pOtQkt9zd
	CCs56GwD9w+tgVp9ZM8Ciugd7z3jX5VOml+LnJ7DwC
X-Received: by 2002:a05:600c:1e8c:b0:483:6d42:25c6 with SMTP id 5b1f17b1804b1-4855670bf36mr54422955e9.23.1773409785065;
        Fri, 13 Mar 2026 06:49:45 -0700 (PDT)
Received: from zovi.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b66e3f8sm206491865e9.14.2026.03.13.06.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 06:49:44 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Christophe Leroy <chleroy@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] module: Fix freeing of charp module parameters when CONFIG_SYSFS=n
Date: Fri, 13 Mar 2026 14:48:01 +0100
Message-ID: <20260313134932.335275-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix freeing of charp module parameters when CONFIG_SYSFS=n and, related to
this, update moduleparam.h to keep its coding style consistent.

Changes since v1 [1]:
* Remove the extern keyword from the declaration of module_destroy_params()
  and update the type of its num parameter from `unsigned` to
  `unsigned int`.
* Add a cleanup patch for parse_args() to similarly update its num
  parameter to `unsigned int` and to synchronize the parameter names
  between its prototype and definition.
* Add a cleanup patch to drop the unnecessary extern keyword for all
  function declarations in moduleparam.h.

[1] https://lore.kernel.org/linux-modules/20260306125457.1377402-1-petr.pavlu@suse.com/

Petr Pavlu (3):
  module: Fix freeing of charp module parameters when CONFIG_SYSFS=n
  module: Clean up parse_args() arguments
  module: Remove extern keyword from param prototypes

 include/linux/moduleparam.h | 100 +++++++++++++++++-------------------
 kernel/module/main.c        |   4 +-
 kernel/params.c             |  29 +++++++----
 3 files changed, 68 insertions(+), 65 deletions(-)


base-commit: 0257f64bdac7fdca30fa3cae0df8b9ecbec7733a
-- 
2.53.0

