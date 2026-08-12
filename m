Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3110377AA0;
	Wed, 12 Aug 2026 03:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786505295; cv=none; b=Rgg2qlnNUB40W6/s++SYoHz1ThZCWTXk20qOQws89wyfoZR9mrh5sgeMqm92gQnllAb0r3M1xSV4R3vZA8Q3LC0lMwPid3fBWNvMXqSzZAa/U/hwU09wSmktWEqrH1WSmRm6iReh+eeNMCSSDoqd3JpEerATzTnQLumG2Aw92GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786505295; c=relaxed/simple;
	bh=LMeVbo/jILdHh3k2XeAvSmtPFPvCwjvSnzqY0Oi9unE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bL4h3bqLDSakuW/XsgNYxl6TRXlosgBzZ8yrFERVXajl3fpe1sjzYWfz32PRe3ShMic6BcCFn3vvdXFGyyiuUwQwU3Aq2Q6BoBszopg4FPFcc+5AHpqTbV63QqkiH1Wq7pQHJtwhsQ4vScWs/PbG/L2N+T3vCgsvPlL2dlShisc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8Bx69FK6HtqQWwAAA--.1322S3;
	Wed, 12 Aug 2026 11:28:10 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJCxPs9J6HtqfoUBAA--.10453S2;
	Wed, 12 Aug 2026 11:28:10 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-modules@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Filter out local and mapping symbols during module load
Date: Wed, 12 Aug 2026 11:28:04 +0800
Message-ID: <20260812032807.15034-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxPs9J6HtqfoUBAA--.10453S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWruFWUuw48GF1fZF18JF1DJwc_yoWfWrc_WF
	yxGFW5Cr47Ga97uFW8trn5XryS9a15G3yDAa4vqF47A3s5Ar43tFs2yrWIgr17XF18Zr4S
	yFnFva4kZwnFgosvyTuYvTs0mTUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbfkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_JFv_Jw1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	JVW8Jr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5
	McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFwIDUUUUU

This series prevents compiler generated local and mapping symbols
from leaking into /proc/kallsyms for loaded modules. This ensures
tracing tools like bpftrace can resolve accurate kernel stacks on
architectures like LoongArch.

Based on the v2 discussion, the changes are now refactored into a
clean three-patch series to eliminate code duplication and clarify
naming.

Tiezhu Yang (3):
  module/kallsyms: Rename is_mapping_symbol() to
    is_local_mapping_symbol()
  module/kallsyms: Refactor current symbol filtering into
    is_kept_symbol()
  module/kallsyms: Filter out local and mapping symbols during module
    load

 include/linux/module_symbol.h |  4 +--
 kernel/module/kallsyms.c      | 59 ++++++++++++++++++-----------------
 scripts/faddr2line            |  2 +-
 scripts/mod/modpost.h         |  2 +-
 4 files changed, 35 insertions(+), 32 deletions(-)

-- 
2.42.0

