Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794608084;
	b=OOCSg2JMQx6dgkZuRFM4CpwjDWVq1gi0gLF59N7NeOJKZ8pJwPwgYl5ItbIYa4z72/1/
	 WFhCoyXgbr4uj2WSBzmOhTNoloMUpXGBe4WkC6DP3WbbwBtao//jYUrSLdvsnUm7sAi4C
	 Hf6fUBxfUz1wsQ8zWxOpUBjjVBjRGBL1bMrp4a1QHJbt7Lq5JYpIXYskVv94ClSRbwETl
	 iQ2oQ66nWS0DCtRN8T+PDGnpEvnM2Cz+zPbMvR455khMBVSgomXF5K+ZLMoH6HiZh0m1U
	 ysDI0GlmAgJmvtHM2pAtadoEb0DKsvAHhRdG2OPjmndR4dq/ymwq4Uh7KP6c7vGEsXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794608084;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=inhYO7njBxxxz63wglLKDs7vlAYadf0cFHKmRlMoUnM=;
	b=zhjrpScKCzK8pPsO60fxY6fNob8spYkM1IkqDoLGqs2sIIqKgvol2L5gZB1uhiEwYJsE
	 ySVwE121tkqSwyI3ms4QCofmNdbc5a+I6W+JcgVpoPheAteyCl8R32NWOc91iV45X9OkY
	 ERQESSfGLcUVezwsy2VMGQ2sSsCoxwxP3ckUeisdMlEDt3Wfv/XX52IsdAH+98uHpp6H2
	 YKGOK/rkpAnBK9+2kEXr0eKGD/gnwMDIxg+kPR+vWATI3In3eIwYtBcFnLniBluMlwEpA
	 10FBg7K3EW9zLYOUEU/PNAT2qkciBO6l/mS8KykWjvEOmE3woDCbTySHImGiCPq9v/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="RldI8/Ss";
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E0E60A3831
	for <linux-modules@vger.kernel.org>; Fri, 13 Nov 2026 22:14:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0E0E60A3831
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RldI8/Ss
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30bcb065bfdso1867349eec.0
        for <linux-modules@vger.kernel.org>; Fri, 13 Nov 2026 14:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794608082; x=1795212882; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=inhYO7njBxxxz63wglLKDs7vlAYadf0cFHKmRlMoUnM=;
        b=RldI8/SsSqY8lw2cvRAiwU7cqvnlV6q0Ztry9wKAhokqvlb76Pt9cdaCLElZ740qHj
         //Ktdtbj8XJ+zeSCkj7OdC1RnbPKS7jXn1fqqm84tpjmWbrkZXbKtvOQbXvLg2kkdFTa
         5wIhhBT/dodbhK6Q+Rq4QtxyTR0nzpB+rCwcU0DeVVI+jAKuIp1UoS7V9QSzswdtSJjz
         hV76Kz5l2w0emhEpHe2qo2Ov1wVEuxQOD1ICntHvPYZZj0/rv5UUCIcM9Ler8/e9/SVy
         QAYmOx4lTFa59kkP9Qlubitqbz+GYRJ73Wckam2i63LobxIWM4tci6GccKHlZx4w8loE
         tN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794608082; x=1795212882;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=inhYO7njBxxxz63wglLKDs7vlAYadf0cFHKmRlMoUnM=;
        b=tod+00W79FErc3PAIWy9mCWL5gYFK2tJAIHYJMFoha5q4mU4Go9Kgz/61nUPJYHZbo
         VAaN3H8+mNu7a63PYD33+FZTNUypfsgDDUuvgPSxARrWe4qmMt77A5uXHM+JjW864FOy
         3IQwH0q9yi/nN1VwCHnM/HsyBejX9R8v3TmbSZOba140fjWk4IS9ktyl2ny3Nu8emxoR
         Ty55w08A49U6Pmnko8DuagLIyC7De7qBDwR52KSGMC9mzLL9cTvQcAs9hU9QRhnVwpQY
         PX4Ost0i/8NfVANQgNVDB+qX/G/Q/QOfFcO/cEbdt7cX0Fs8n/tS2xD/JZDJJME4MMv0
         pldg==
X-Forwarded-Encrypted: i=1; AL+hErEjBDekTKYYQJyx5oZ2q2SA6ovqVnlOkECdXT874I0974q9JFe6RQcXY7gQbKAOrTDyIbiJOj0LDIg5i701@vger.kernel.org
X-Gm-Message-State: APuU4Z/qHU3AFtH9K25i2PPcofnGheiO66PJ2orCl3c282X+GF8v+ra+
	rsmHVfE3u2FBJ0F+12TSCSekPiedb7mtJhFNLjY+AsevVUMlko2AZhYgbgFmG53qZR9mc4CeRUn
	0KbuGqc6JDlQTew==
X-Received: from dyrp21.prod.google.com ([2002:a05:693c:69d5:b0:343:520f:7a80])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:d189:b0:36e:e349:f2cb with SMTP id 5a478bee46e88-3796628e28amr3392731eec.19.1794608081264;
 Fri, 13 Nov 2026 14:14:41 -0800 (PST)
Date: Fri, 13 Nov 2026 14:12:53 -0800
In-Reply-To: <20261113221248.3535369-11-wusamuel@google.com>
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113221248.3535369-11-wusamuel@google.com>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261113221248.3535369-19-wusamuel@google.com>
Subject: [PATCH bpf-next v3 8/9] libbpf: Resolve typeless ksyms via
 KALLSYMS_QUERY_BY_NAME ioctl
From: Samuel Wu <wusamuel@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	David Laight <david.laight.linux@gmail.com>, Samuel Wu <wusamuel@google.com>, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-modules@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

libbpf parses all of /proc/kallsyms to resolve typeless ksyms.

Use KALLSYMS_QUERY_BY_NAME instead: exact names, plus "<name>.llvm."
prefix matches. Ambiguous matches at different addresses fail the load.
A missing strong extern still fails and a missing weak extern is 0,
without a text scan.

On any other error (e.g. -ENOTTY on older kernels, or -EPERM), fall back
to the text parser.

Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 tools/lib/bpf/libbpf.c | 99 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 97 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 44134421bd7d..f3f3475a64d3 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -59,6 +59,34 @@
 #define BPF_FS_MAGIC		0xcafe4a11
 #endif
 
+#ifndef KALLSYMS_QUERY_BY_NAME
+/* 'f' is PROCFS_IOCTL_MAGIC */
+#define KALLSYMS_QUERY_BY_NAME	_IOC(_IOC_READ | _IOC_WRITE, 'f', 48, 0)
+
+enum kallsyms_query_flags {
+	KALLSYMS_QUERY_NAME_PREFIX = 0x01,
+};
+
+struct kallsyms_query_sym {
+	__u64 sym_addr;
+	__u64 sym_size;
+	__u64 sym_name;
+	__u64 sym_name_len;
+	__u64 sym_module;
+	__u64 sym_module_len;
+};
+
+struct kallsyms_query_by_name {
+	__u64 size;
+	__u64 query_flags;
+	__u64 query_name;
+	__u64 module_filter;
+	__u64 pos;
+	__u64 sym;
+	__u64 sym_struct_size;
+};
+#endif
+
 #define MAX_EVENT_NAME_LEN	64
 
 #define BPF_FS_DEFAULT_PATH "/sys/fs/bpf"
@@ -9421,8 +9449,75 @@ static int kallsyms_cb(unsigned long long sym_addr, char sym_type,
 	return 0;
 }
 
-static int bpf_object__read_kallsyms_file(struct bpf_object *obj)
+static int query_ksym_by_name(int fd, struct extern_desc *ext, bool lto_prefix)
+{
+	struct kallsyms_query_sym sym = {};
+	struct kallsyms_query_by_name q = {
+		.size = sizeof(q),
+		.query_flags = lto_prefix ? KALLSYMS_QUERY_NAME_PREFIX : 0,
+		.query_name = ptr_to_u64(ext->name),
+		.sym = ptr_to_u64(&sym),
+		.sym_struct_size = sizeof(sym),
+	};
+	char prefix_buf[512];
+	int n;
+
+	if (lto_prefix) {
+		n = snprintf(prefix_buf, sizeof(prefix_buf), "%s.llvm.", ext->name);
+		if (n < 0 || n >= sizeof(prefix_buf))
+			return 0;
+		q.query_name = ptr_to_u64(prefix_buf);
+	}
+
+	while (!ioctl(fd, KALLSYMS_QUERY_BY_NAME, &q)) {
+		if (!ext->is_set) {
+			ext->is_set = true;
+			ext->ksym.addr = sym.sym_addr;
+			pr_debug("extern (ksym) '%s': set to 0x%llx\n",
+				 ext->name, ext->ksym.addr);
+		} else if (sym.sym_addr != ext->ksym.addr) {
+			pr_warn("extern (ksym) '%s': resolution is ambiguous: 0x%llx or 0x%llx\n",
+				ext->name, ext->ksym.addr,
+				(unsigned long long)sym.sym_addr);
+			return -EADDRNOTAVAIL;
+		}
+		q.pos++;
+	}
+
+	return errno == ENOENT ? 0 : -errno;
+}
+
+static int bpf_object__resolve_typeless_ksyms(struct bpf_object *obj)
 {
+	struct extern_desc *ext;
+	int err = 0;
+	int fd;
+	int i;
+
+	fd = open("/proc/kallsyms", O_RDONLY | O_CLOEXEC);
+	if (fd < 0) {
+		err = -errno;
+		pr_warn("failed to open /proc/kallsyms: %s\n", errstr(err));
+		return err;
+	}
+
+	for (i = 0; i < obj->nr_extern && !err; i++) {
+		ext = &obj->externs[i];
+		if (ext->type != EXT_KSYM || ext->ksym.type_id)
+			continue;
+
+		/* Check exact name and then LTO .llvm.<hash> prefix */
+		err = query_ksym_by_name(fd, ext, false);
+		if (!err)
+			err = query_ksym_by_name(fd, ext, true);
+	}
+	close(fd);
+	if (!err || err == -EADDRNOTAVAIL)
+		return err;
+
+	/* Other errors (e.g. -ENOTTY, -EPERM): parse the text file */
+	pr_debug("KALLSYMS_QUERY_BY_NAME failed (%s), falling back to /proc/kallsyms\n",
+		 errstr(err));
 	return libbpf_kallsyms_parse(kallsyms_cb, obj);
 }
 
@@ -9699,7 +9794,7 @@ static int bpf_object__resolve_externs(struct bpf_object *obj,
 			return -EINVAL;
 	}
 	if (need_kallsyms) {
-		err = bpf_object__read_kallsyms_file(obj);
+		err = bpf_object__resolve_typeless_ksyms(obj);
 		if (err)
 			return -EINVAL;
 	}
-- 
2.56.0.679.gc527c65306-goog

