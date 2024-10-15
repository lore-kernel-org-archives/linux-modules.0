Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C3621E3DB
	for <linux-modules@vger.kernel.org>; Tue, 15 Oct 2024 23:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729034221; cv=none; b=FCd1xiCYmr+m2I9WmKFSq+GUYhgnl/qSC76tmU4HIwmmWygOkrlSZd6m6R/mpDTvxbcGdm0WYFBLc2PRYr9NlRDCx3AcrRhfxxRZTsfBbAV2c1h1GqxaiM/rBCo3FbuaC8he1/GmVdDDuZsWTMbYbpN0s1No82zSDjwgIKaGLxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729034221; c=relaxed/simple;
	bh=+RilbqdhmWa1t4pvNpgCLBopLcVUsyKeWfzBpA7u4KI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hOGppVJrhu65r/vjadipjYM4stgJymHCuCXvxZTj3Ly6Cdzs8cc3K0azlO3uVLxxwBBlOi4h+8C/SfZwMwY90h31W4qBDyWkVaVeYjzlvQVR2IhFhj6zDEJMGHa4KIgblrUgG9NPFIkjlvAcZAqiGRvXIcM7/LZ+ceX9bYcJkow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UYtUg4cx; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UYtUg4cx"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e389169f92so45612867b3.0
        for <linux-modules@vger.kernel.org>; Tue, 15 Oct 2024 16:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729034219; x=1729639019; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DbU5L1HNnvGi4SfbIk5euXMkUm30knwW6Q9Xw1d4gcg=;
        b=UYtUg4cx0IPO3HbL8jfYdyaPuxXQXNAHwc7lYuFdsVpa9qb3BqMI5O5JdPEhImy190
         BRQ12Lpe8mNtcXgQzS9rfzQZPCVFlb0XWcI8KphoM8oZHh55N/U8C2lAtwgkzdpvdzav
         wwdocIqqN0+rDx1Aej/c39xNQMreFUx7STYLXXsFTKTOo1zZG5hqGyhZC/ikOXFRTHAQ
         nwJS3oYa7728VgKKXd/q/1OH2QbqS3TzdQqHsmLyMoe9sSwMM939FFbSC3phUBt8pN+b
         Ko5p+ZtwMXbVxjC0P4BdldOM907trNO3BfOv2aHQU3+3uziUMEj+QU93wmgH8Xvn4sz1
         hUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729034219; x=1729639019;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DbU5L1HNnvGi4SfbIk5euXMkUm30knwW6Q9Xw1d4gcg=;
        b=xNu29abPrX4UkZkwEpcgUqXy97BoGVxpZSTHowZyxbJr4CJHhxwzeIy2H0KjYYoKB9
         5U8GRZ/fYjim+7bctvIijfUR/7vSNoxHAUUTQpfi9/BR7Xv79c1IKXAP2auK+ux1qm9Q
         dVjWxbghFBlN4aR92XMP0CmwdQz5Drz80aUReRsQJ710B0ZKSf9v/94+OLxE3V0LLLDy
         leGZpct/RWC1pPFdmO94CQBJxF8wwpSDvZcsIqo223cd5Zj0lnDpEJrg7yHSZxOWJbc+
         2LpGZAeODHzkXJ0z3I698kW+Ie4KkHUaslbBa6k6RIKwbGBFTtMQHEAxNAbknai550bz
         4zlA==
X-Forwarded-Encrypted: i=1; AJvYcCVPoqRAFZxrsYxN3VqmF/pwRVzqkchmFJ5iAjmT9xHoBJH0jzKN/2vXKtqzmhsDgK8/k134lDQrkhnwg2Pa@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbb24IHazYB9o33NBNPE1afaPAFNQO06yAwbIeX4tBc2Sbt10i
	s1Pr1OeC2Kxa1wjaZ0sma6nVxQUXOQT8cgfnYlE8PsWCOLWD1CBN0lZQ+PckkPDgfuDCMAReiiw
	x2FqoQg==
X-Google-Smtp-Source: AGHT+IE9M/QPEawpkYrmCgoLO4MqhipBXakrVD75onOl9tgo/7Jaz/A58z0xOGdMWl08TQoMGHL6CygxKbeq
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a05:690c:6408:b0:6e3:da91:3e17 with SMTP
 id 00721157ae682-6e3da915a37mr7657b3.2.1729034219005; Tue, 15 Oct 2024
 16:16:59 -0700 (PDT)
Date: Tue, 15 Oct 2024 23:16:34 +0000
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241015231651.3851138-1-mmaurer@google.com>
Subject: [PATCH 00/12] Module Validation Refactor
From: Matthew Maurer <mmaurer@google.com>
To: mcgrof@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	samitolvanen@google.com, Matthew Maurer <mmaurer@google.com>
Content-Type: text/plain; charset="UTF-8"

Split out from Extended MODVERSIONS Support [1]

This series refactors module validation during loading to ensure that
everything is checked on its way in. This is intended to make the code
robust enough that we can more confidently add new pieces like extended
MODVERSIONS.

[1] https://lore.kernel.org/all/20240925233854.90072-1-mmaurer@google.com/

Matthew Maurer (12):
  module: Take const arg in validate_section_offset
  module: Factor out elf_validity_ehdr
  module: Factor out elf_validity_cache_sechdrs
  module: Factor out elf_validity_cache_secstrings
  module: Factor out elf_validity_cache_index_info
  module: Factor out elf_validity_cache_index_mod
  module: Factor out elf_validity_cache_index_sym
  module: Factor out elf_validity_cache_index_str
  module: Group section index calculations together
  module: Factor out elf_validity_cache_strtab
  module: Additional validation in elf_validity_cache_strtab
  module: Reformat struct for code style

 kernel/module/internal.h |   7 +-
 kernel/module/main.c     | 569 +++++++++++++++++++++++++++++----------
 2 files changed, 428 insertions(+), 148 deletions(-)

-- 
2.47.0.rc1.288.g06298d1525-goog

