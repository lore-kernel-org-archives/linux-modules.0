Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02F844606A
	for <linux-modules@vger.kernel.org>; Thu, 20 Aug 2026 12:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787230224; cv=none; b=HIK352x1me1Rgd076yjH0sivUp3ajyF2AlMnwEl1OFdS3SmcRt4oBatkGwRTYY+vYbHZ7lKVxNh3bHyJopDxQ2fXdowfKKoHeJ1tTzgtxGhZ5VIOmR53Xfa/KyFQs5ENw8Fs6C7fKy4yTXKGvg/oRR8UM9r+k5B7OnD9LK49mjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787230224; c=relaxed/simple;
	bh=t/wqrQG7mh/bLDGlXi3QvBm9+4nZZM3xHgnq1Ct3iO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J0pVMASBjd0uPv/7JTRxuhQRLnZ2xedsI0q97rdwLWYyBP7pv0ACerCAeSbwAUUKeSa+3dgJ94DMDxs29ChHatpaZmo0ZJYS8x0YxCftT/dXnVy7mDUQCyQjoM3mRxSdFjquVau4Y3BqllEu0aYyvOuZVKS8PVlpAQWZRXA7ojg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8DxTtMF+IZqYB0DAA--.9136S3;
	Thu, 20 Aug 2026 20:50:13 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJAx2c0A+IZqX_QLAA--.6716S2;
	Thu, 20 Aug 2026 20:50:08 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-modules@vger.kernel.org,
	loongarch@lists.linux.dev,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v4 0/3] Ignore local labels and mapping symbols during module load
Date: Thu, 20 Aug 2026 20:50:04 +0800
Message-ID: <20260820125007.22943-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAx2c0A+IZqX_QLAA--.6716S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cr1DKFWDuFWrJryDGw48uFX_yoW8Xw13pF
	43CF43Xr4UZr97Can7Gw4j9Fy5u3ykXr4FgF13Gw1xAF1qq3W8Zr92kr1F934UAryUKF40
	vr17A3yqga48AwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0epB3UUUUU==

This series prevents compiler generated local labels and mapping symbols
from leaking into /proc/kallsyms for loaded modules. This ensures tracing
tools like bpftrace can resolve accurate kernel stacks on architectures
like LoongArch.

Based on the latest modules-next tree:
https://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git/log/?h=modules-next

There are many discussions in the previous version, here is the link:
https://lore.kernel.org/loongarch/20260812032807.15034-1-yangtiezhu@loongson.cn/

v4:
  (1) Use is_ignored_kernel_symbol() and update
      tools/perf/util/symbol.h in patch #1
  (2) Keep using is_core_symbol() in patch #2
  (3) Update commit messages of the three patches

Cc the maintainers of the updated non-module files:
  (1) Josh Poimboeuf <jpoimboe@kernel.org> -- scripts/faddr2line
  (2) Nathan Chancellor <nathan@kernel.org> -- scripts/mod/modpost.h
  (3) Namhyung Kim <namhyung@kernel.org> -- tools/perf/util/symbol.h

Tiezhu Yang (3):
  module/kallsyms: Rename is_mapping_symbol() to
    is_ignored_kernel_symbol()
  module/kallsyms: Refactor current symbol filtering into
    is_core_symbol()
  module/kallsyms: Ignore local labels and mapping symbols during module
    load

 include/linux/module_symbol.h |  7 +++--
 kernel/module/kallsyms.c      | 59 ++++++++++++++++++-----------------
 scripts/faddr2line            |  2 +-
 scripts/mod/modpost.h         |  2 +-
 tools/perf/util/symbol.h      |  4 +--
 5 files changed, 39 insertions(+), 35 deletions(-)

-- 
2.42.0

