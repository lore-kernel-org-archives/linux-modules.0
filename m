MIME-Version: 1.0
In-Reply-To: <54E5F497.7030209@mentor.com>
References: <1424177796-17923-1-git-send-email-harish_kandiga@mentor.com>
	<CAKi4VA+nJknEwkQfUWf0VbcEMzzz3uHwwNe8OuWQOi-K0sWxjQ@mail.gmail.com>
	<874mqjuaky.fsf@rustcorp.com.au>
	<CAKi4VAKpzUcakX+BY8dYE8Jx4BUOqy_-LZWH5gJWtwn3EdbE0g@mail.gmail.com>
	<87vbiysv1v.fsf@rustcorp.com.au>
	<CAKi4VAKc_zrPptt2ZKT_Jj8bLdL1bt0emhtEuodV2WKkas9ZOw@mail.gmail.com>
	<54E5795C.5050804@mentor.com>
	<CAKi4VA+ceEsQm30+4q_hvgtm2Uwo1cJSQdJErUh6hsd=fwbe0g@mail.gmail.com>
	<54E5D7F1.2090804@mentor.com>
	<CAKi4VAJ=sx-GvcQ8vj70F=F2x3p-LW8RCQ1eycZhssBu1Tr58g@mail.gmail.com>
	<54E5ED12.9040104@mentor.com>
	<54E5F497.7030209@mentor.com>
Date: Sat, 28 Feb 2015 14:28:01 -0300
Message-ID: <CAKi4VALFbzrYxUfDvaXw52Czw+ynBOVZrVjga+Luys+gsdsv-w@mail.gmail.com>
Subject: Re: [PATCH] libkmod-module: Remove directory existence check for KMOD_MODULE_BUILTIN
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Harish Jenny Kandiga Nagaraj <harish_kandiga@mentor.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-modules <linux-modules@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>, greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Thu, Feb 19, 2015 at 12:35 PM, Harish Jenny Kandiga Nagaraj
<harish_kandiga@mentor.com> wrote:
>
> On Thursday 19 February 2015 07:32 PM, Harish Jenny Kandiga Nagaraj wrote:
>> On Thursday 19 February 2015 06:13 PM, Lucas De Marchi wrote:
>>> On Thu, Feb 19, 2015 at 10:32 AM, Harish Jenny Kandiga Nagaraj
>> diff --git a/libkmod/libkmod-internal.h b/libkmod/libkmod-internal.h
>> index 417f232..f6ffd3e 100644
>> --- a/libkmod/libkmod-internal.h
>> +++ b/libkmod/libkmod-internal.h
>> @@ -46,6 +46,13 @@ static _always_inline_ _printf_format_(2, 3) void
>>  #  endif
>>  #endif
>>
>> +/* Flags to kmod_builtin_status() */
>> +enum kmod_builtin_status {
>> +    KMOD_BUILTIN_UNKNOWN = 0,
>> +    KMOD_BUILTIN_NO = 1,
>> +    KMOD_BUILTIN_YES = 2
>> +};
>> +
>>  void kmod_log(const struct kmod_ctx *ctx,
>>          int priority, const char *file, int line, const char *fn,
>>          const char *format, ...) __attribute__((format(printf, 6, 7))) __attribute__((nonnull(1, 3, 5)));
>> @@ -92,6 +99,7 @@ int kmod_lookup_alias_from_symbols_file(struct kmod_ctx *ctx, const char *name,
>>  int kmod_lookup_alias_from_aliases_file(struct kmod_ctx *ctx, const char *name, struct kmod_list **list) __attribute__((nonnull(1, 2, 3)));
>>  int kmod_lookup_alias_from_moddep_file(struct kmod_ctx *ctx, const char *name, struct kmod_list **list) __attribute__((nonnull(1, 2, 3)));
>>  int kmod_lookup_alias_from_builtin_file(struct kmod_ctx *ctx, const char *name, struct kmod_list **list) __attribute__((nonnull(1, 2, 3)));
>> +int kmod_just_lookup_alias_from_builtin_file(struct kmod_ctx *ctx, const char *name)__attribute__((nonnull(1, 2)));
>>  int kmod_lookup_alias_from_commands(struct kmod_ctx *ctx, const char *name, struct kmod_list **list) __attribute__((nonnull(1, 2, 3)));
>>  void kmod_set_modules_visited(struct kmod_ctx *ctx, bool visited) __attribute__((nonnull((1))));
>>  void kmod_set_modules_required(struct kmod_ctx *ctx, bool required) __attribute__((nonnull((1))));
>> @@ -143,9 +151,9 @@ int kmod_module_parse_depline(struct kmod_module *mod, char *line) __attribute__
>>  void kmod_module_set_install_commands(struct kmod_module *mod, const char *cmd) __attribute__((nonnull(1)));
>>  void kmod_module_set_remove_commands(struct kmod_module *mod, const char *cmd) __attribute__((nonnull(1)));
>>  void kmod_module_set_visited(struct kmod_module *mod, bool visited) __attribute__((nonnull(1)));
>> -void kmod_module_set_builtin(struct kmod_module *mod, bool builtin) __attribute__((nonnull((1))));
>> +void kmod_module_set_builtin(struct kmod_module *mod, enum kmod_builtin_status builtin) __attribute__((nonnull((1))));
>>  void kmod_module_set_required(struct kmod_module *mod, bool required) __attribute__((nonnull(1)));
>> -
>> +bool kmod_module_is_builtin(const struct kmod_module *mod);
>>
>>  /* libkmod-file.c */
>>  struct kmod_file *kmod_file_open(const struct kmod_ctx *ctx, const char *filename) _must_check_ __attribute__((nonnull(1,2)));
>> diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
>> index 19bb2ed..6b2f2f1 100644
>> --- a/libkmod/libkmod-module.c
>> +++ b/libkmod/libkmod-module.c
>> @@ -98,7 +98,7 @@ struct kmod_module {
>>       * is set. There's nothing much useful one can do with such a
>>       * "module", except knowing it's builtin.
>>       */
>> -    bool builtin : 1;
>> +    enum kmod_builtin_status builtin;
>>  };
>>
>>  static inline const char *path_join(const char *path, size_t prefixlen,
>> @@ -210,7 +210,7 @@ void kmod_module_set_visited(struct kmod_module *mod, bool visited)
>>      mod->visited = visited;
>>  }
>>
>> -void kmod_module_set_builtin(struct kmod_module *mod, bool builtin)
>> +void kmod_module_set_builtin(struct kmod_module *mod, enum kmod_builtin_status builtin)
>>  {
>>      mod->builtin = builtin;
>>  }
>> @@ -220,6 +220,15 @@ void kmod_module_set_required(struct kmod_module *mod, bool required)
>>      mod->required = required;
>>  }
>>
>> +bool kmod_module_is_builtin(const struct kmod_module *mod)
>> +{
>> +    int builtin = mod->builtin;
>> +
>> +    if (builtin == KMOD_BUILTIN_UNKNOWN)
>> +        builtin = kmod_just_lookup_alias_from_builtin_file(mod->ctx, mod->name);
>> +
>> +    return mod->builtin == KMOD_BUILTIN_YES;
>> +}
>>  /*
>>   * Memory layout with alias:
>>   *
>> @@ -924,7 +933,7 @@ KMOD_EXPORT int kmod_module_apply_filter(const struct kmod_ctx *ctx,
>>                  module_is_blacklisted(mod))
>>              continue;
>>
>> -        if ((filter_type & KMOD_FILTER_BUILTIN) && mod->builtin)
>> +        if ((filter_type & KMOD_FILTER_BUILTIN) && kmod_module_is_builtin(mod))
>>              continue;
>>
>>          node = kmod_list_append(*output, mod);
>> @@ -1713,7 +1722,7 @@ KMOD_EXPORT int kmod_module_get_initstate(const struct kmod_module *mod)
>>      if (mod == NULL)
>>          return -ENOENT;
>>
>> -    if (mod->builtin)
>> +    if (kmod_module_is_builtin(mod))
>>          return KMOD_MODULE_BUILTIN;
>>
>>      pathlen = snprintf(path, sizeof(path),
>> diff --git a/libkmod/libkmod.c b/libkmod/libkmod.c
>> index 1a5a66b..d79bb12 100644
>> --- a/libkmod/libkmod.c
>> +++ b/libkmod/libkmod.c
>> @@ -525,7 +525,7 @@ int kmod_lookup_alias_from_builtin_file(struct kmod_ctx *ctx, const char *name,
>>              goto finish;
>>          }
>>
>> -        kmod_module_set_builtin(mod, true);
>> +        kmod_module_set_builtin(mod, KMOD_BUILTIN_YES);
>>          *list = kmod_list_append(*list, mod);
>>          if (*list == NULL)
>>              err = -ENOMEM;
>> @@ -536,6 +536,39 @@ finish:
>>      return err;
>>  }
>>
>> +int kmod_just_lookup_alias_from_builtin_file(struct kmod_ctx *ctx,
>> +        const char *name) {
>> +    char *line = NULL;
>> +
>> +    if (ctx->indexes[KMOD_INDEX_MODULES_BUILTIN]) {
>> +        DBG(ctx, "use mmaped index '%s' modname=%s\n",
>> +                index_files[KMOD_INDEX_MODULES_BUILTIN].fn, name);
>> +        line = index_mm_search(ctx->indexes[KMOD_INDEX_MODULES_BUILTIN], name);
>> +    } else {
>> +        struct index_file *idx;
>> +        char fn[PATH_MAX];
>> +
>> +        snprintf(fn, sizeof(fn), "%s/%s.bin", ctx->dirname,
>> +                index_files[KMOD_INDEX_MODULES_BUILTIN].fn);
>> +        DBG(ctx, "file=%s modname=%s\n", fn, name);
>> +
>> +        idx = index_file_open(fn);
>> +        if (idx == NULL) {
>> +            DBG(ctx, "could not open builtin file '%s'\n", fn);
>> +            goto finish;
>> +        }
>> +
>> +        line = index_search(idx, name);
>> +        index_file_close(idx);
>> +    }
>> +
>> +    if (line != NULL)
>> +        return KMOD_BUILTIN_YES;
>> +
>> +finish:
>> +        return KMOD_BUILTIN_NO;
>> +}
>> +
>>  char *kmod_search_moddep(struct kmod_ctx *ctx, const char *name)
>>  {
>>      struct index_file *idx;
>>
>>
>>
>
>
> I guess there are some mistakes
>
> 1) return mod->builtin == KMOD_BUILTIN_YES;  should be made to
> return builtin == KMOD_BUILTIN_YES;
> 2) S_ISDIR check needs to be removed.
>
> Lucas,
> In any case , Can this patch can be taken in sequence?
> My first original patch of removing directory check can be taken first. Then the necessary changes required. (you might add as well in your free time as suggested by you)

I fixed some mistakes like you pointed out, added minor changes and
applied to the master branch:
https://git.kernel.org/cgit/utils/kernel/kmod/kmod.git/commit/?id=fd44a98ae2eb5eb32161088954ab21e58e19dfc4

I also added some tests to the testsuite on top. Could you please take
a look if everything is right for your use case in master branch?

thanks

-- 
Lucas De Marchi
