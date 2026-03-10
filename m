Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C955E393DCF
	for <linux-modules@vger.kernel.org>; Tue, 10 Mar 2026 02:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773110302; cv=none; b=bEDPKxCghO/ieDkW6llqTsmSoukbRMkSYtXzjMjKy9cIPz45U27q6W6MYYVhQoKUTV4jh22P/wzI4IHJ/Z0IQopsqNLDVUIwz5krldDwKRsp3QmXaNR9yauVHMK4IQjUqYQFP3Eqz5GCePqY1FE9AirKvLlQ5G0Nv9L9dLM049s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773110302; c=relaxed/simple;
	bh=FR9+8Z11uB2sj7UIMZFphfwYl5e3EKD8LS7JXtxa9uI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mvqfanlf3rcsokv6rSVJvuASBmsS9eYGbePBiXhq699mw++iWgZkweN42dCdg8XFydSRUfha48NG3Xc18ryOobFmVjRVXqdI2wqBixmB2GMUe6Wa9l/EUbyRLpDWoc1f6JTpFERiZC0WbsG9jRUcEMLZKA6/lYM32Qwt1n8Qdjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVdKrWvS; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVdKrWvS"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2aea68839a5so302075ad.1
        for <linux-modules@vger.kernel.org>; Mon, 09 Mar 2026 19:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773110300; x=1773715100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VYtjdoRAw6FiTaxbT7dGmbgMbB5a88kiHX4uF9KdvQg=;
        b=cVdKrWvSWcljCSvOrkn4B9k+5Wt1mjIiI+VVQFayQFiJ1sJ3FHKc/zEgdSxtVBgf5g
         Mr81qLLlwahmjhBquYPGRlK61MZ8OYdGwlNMXh7xpPV2uQ7U970vRHq7tKn3jtup3kfQ
         KnFfZ1mf2AgceZOGDakuqPkIn2rnSSJRZLvzp7Iq638EDdD4/eiVzmP5sXkcrGisAMCl
         IC8vnArFUqvN/koVDWXRouXr9tzSV8PPE/2Xh7IkAnPqrlXiUEKon47dWqKTnKMhxWzo
         Tt6Qwq+ROqZW4nNG6XeS4U9/7aoSswcZqpBFnzDVCLk9dzASQItXSyQN5AGfLYckc8sr
         0Kdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773110300; x=1773715100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYtjdoRAw6FiTaxbT7dGmbgMbB5a88kiHX4uF9KdvQg=;
        b=mZtyilMJfQLEdiBjQMM/5BRBmnYQvTaJgmMGXKkvtNl5D9a5fB2knb7C8bemTcfewF
         MnSwd40QfHyYwLcsLua1cdEPZxhz9kbR4P9rXKV/KYgO2tLLMKKjumMv+LvZVWeN7niH
         A1dO01XpWUUcZXGgD+u2BLhNizkzA27+LQbBdETEsrXR4PQMAB9hpnhzGvNWdyHMbvhp
         Woh7Lus7l8PSPHKHBoxzkWwJSm/Pf8sr+F8zCqrNwaWkIao2ovLlkpOePVrgoZRl5Sul
         Zwz3/VqFVguLjMZznknti1wFYPkZtppmFWtJ3Qh4relRvGkW5rAvcT6yWgXIwxrpCS9K
         LtnQ==
X-Gm-Message-State: AOJu0YzPxG17KnCtSwK2W9MB7qeMaEKIflRNkaHd3ctEvEKaqCPOiVTB
	VCIv9cimFe3W8Roa12WEzricD3gC1qAwc7WE6kTJ5UPlirmNgmtc62cV
X-Gm-Gg: ATEYQzyW6l0bPmzctFht6FUayKADRpSTKWMQ5UlBwYPk8sMy9tDCp9JiGTyE343tOIv
	JCWj9gbuFk3MaHKCG8vg+PBC1fBL+fiultotNJvdixsNN7oJh3RqBNeE99o+W5VFPB7iMSQzjGq
	LlNEnqyYpIZfzVptvTj/XTwV86EHEbbKXTtVGcDAIZEuUMwujK4g4vLYZ2T5cwC7uURjW/+T2/q
	9I2NzLYt9ThhJ78nXWmbvHj579QUdM+qLdvJ1Z5qizsNPVbjOQoRgmhdCRaik1UBy1nFv7u7jyi
	tYUF+KN2wg+kf8pKpuYGRTNBC5eM3Dyb8ejN1ZpthSvpouw8EGTqbH9XfHqy/ChqLgCbpP1GnB/
	I9948MFhkXTqRSPPmwgZFr2ESOXaR5Y4H9OUMGH1thTsXyhmhBLU/l7EU4A019YtsgN+cbTzjks
	pQDnxX/RHjwgapCZ692Dv3TlFjARIwYcz2L1g253Jp+O8U3uhSgYF7m2Q=
X-Received: by 2002:a17:902:e892:b0:2ae:4da9:afce with SMTP id d9443c01a7336-2aea1e1b6bemr14749725ad.23.1773110299974;
        Mon, 09 Mar 2026 19:38:19 -0700 (PDT)
Received: from yafangs-Air ([2409:891f:1da1:e042:e558:2209:4ede:3b06])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83fa8895sm176225245ad.72.2026.03.09.19.38.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Mar 2026 19:38:19 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	atomlin@atomlin.com
Cc: linux-modules@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3] module: print version for external modules in print_modules()
Date: Tue, 10 Mar 2026 10:38:07 +0800
Message-ID: <20260310023807.80140-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We maintain a vmcore analysis script on each server that automatically
parses /var/crash/XXXX/vmcore-dmesg.txt to categorize vmcores. This helps
us save considerable effort by avoiding analysis of known bugs.

For vmcores triggered by a driver bug, the system calls print_modules() to
list the loaded modules. However, print_modules() does not output module
version information. Across a large fleet of servers, there are often many
different module versions running simultaneously, and we need to know which
driver version caused a given vmcore.

Currently, the only reliable way to obtain the module version associated
with a vmcore is to analyze the /var/crash/XXXX/vmcore file itself—an
operation that is resource-intensive. Therefore, we propose printing the
driver version directly in the log, which is far more efficient.

The motivation behind this change is that the external NVIDIA driver
[0] frequently causes kernel panics across our server fleet.
While we continuously upgrade to newer NVIDIA driver versions,
upgrading the entire fleet is time-consuming. Therefore, we need to
identify which driver version is responsible for each panic.

In-tree modules are tied to the specific kernel version already, so
printing their versions is redundant. However, for external drivers (like
proprietary networking or GPU stacks), the version is the single most
critical piece of metadata for triage. Therefore, to avoid bloating the
information about loaded modules, we only print the version for external
modules.

- Before this patch

  Modules linked in: mlx5_core(O) nvidia(PO) nvme_core

- After this patch

  Modules linked in: mlx5_core-5.8-2.0.3(O) nvidia-535.274.02(PO) nvme_core
                              ^^^^^^^^^^          ^^^^^^^^^^^

Note: nvme_core is a in-tree module[1], so its version isn't printed.

As pointed out by Sami, we must ensure mod->version is valid in
print_modules():

 : We release the memory for mod->version in:
 :
 :   free_module
 :     -> module_remove_modinfo_attrs
 :     -> attr->free = free_modinfo_version
 :
 : And this happens before the module is removed from the list.
 : Couldn't there be a race condition where we read a non-NULL
 : mod->version here, but the buffer is being concurrently released
 : by another core that's unloading the module, resulting in a
 : use-after-free in the pr_cont call?
 :
 : In order to do this safely, we should presumably drop the attr->free
 : call from module_remove_modinfo_attrs and release the attributes
 : only after the synchronize_rcu call in free_module (there's already
 : free_modinfo we can use), so mod->version is valid for the entire
 : time the module is on the list.

Link: https://github.com/NVIDIA/open-gpu-kernel-modules/tags [0]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/nvme/host/core.c?h=v6.19-rc3#n5448 [1]
Suggested-by: Petr Pavlu <petr.pavlu@suse.com>
Suggested-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/module/main.c  | 29 +++++++++++++++++------------
 kernel/module/sysfs.c |  2 --
 2 files changed, 17 insertions(+), 14 deletions(-)

---
v2->v3:
- ensure mod->version is valid when printing it. (Sami)

v1->v2:
- print it for external module only (Petr, Aaron)
- add comment for it (Aaron)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 2bac4c7cd019..c8f41fa90f8a 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1384,6 +1384,17 @@ static void free_mod_mem(struct module *mod)
 	module_memory_free(mod, MOD_DATA);
 }
 
+static void free_modinfo(struct module *mod)
+{
+	const struct module_attribute *attr;
+	int i;
+
+	for (i = 0; (attr = modinfo_attrs[i]); i++) {
+		if (attr->free)
+			attr->free(mod);
+	}
+}
+
 /* Free a module, remove from lists, etc. */
 static void free_module(struct module *mod)
 {
@@ -1422,6 +1433,7 @@ static void free_module(struct module *mod)
 	module_bug_cleanup(mod);
 	/* Wait for RCU synchronizing before releasing mod->list and buglist. */
 	synchronize_rcu();
+	free_modinfo(mod);
 	if (try_add_tainted_module(mod))
 		pr_err("%s: adding tainted module to the unloaded tainted modules list failed.\n",
 		       mod->name);
@@ -1779,17 +1791,6 @@ static int setup_modinfo(struct module *mod, struct load_info *info)
 	return 0;
 }
 
-static void free_modinfo(struct module *mod)
-{
-	const struct module_attribute *attr;
-	int i;
-
-	for (i = 0; (attr = modinfo_attrs[i]); i++) {
-		if (attr->free)
-			attr->free(mod);
-	}
-}
-
 bool __weak module_init_section(const char *name)
 {
 	return strstarts(name, ".init");
@@ -3901,7 +3902,11 @@ void print_modules(void)
 	list_for_each_entry_rcu(mod, &modules, list) {
 		if (mod->state == MODULE_STATE_UNFORMED)
 			continue;
-		pr_cont(" %s%s", mod->name, module_flags(mod, buf, true));
+		pr_cont(" %s", mod->name);
+		/* Only append version for out-of-tree modules */
+		if (mod->version && test_bit(TAINT_OOT_MODULE, &mod->taints))
+			pr_cont("-%s", mod->version);
+		pr_cont("%s", module_flags(mod, buf, true));
 	}
 
 	print_unloaded_tainted_modules();
diff --git a/kernel/module/sysfs.c b/kernel/module/sysfs.c
index 01c65d608873..17d1796d6dc7 100644
--- a/kernel/module/sysfs.c
+++ b/kernel/module/sysfs.c
@@ -278,8 +278,6 @@ static void module_remove_modinfo_attrs(struct module *mod, int end)
 		if (!attr->attr.name)
 			break;
 		sysfs_remove_file(&mod->mkobj.kobj, &attr->attr);
-		if (attr->free)
-			attr->free(mod);
 	}
 	kfree(mod->modinfo_attrs);
 }
-- 
2.47.3

