Shader "ABKaspo/A.U.R.W./Simple/Water"
    {
        Properties
        {
            _depth("Depth", Float) = 1
            _depthStrength("DepthStrength", Range(0, 2)) = 2
            _deepWaterColor("Deep", Color) = (0, 0.5644836, 1, 1)
            _shallowWaterColor("Shallow", Color) = (0, 0.5279799, 1, 1)
            _smoothness("Smoothness", Float) = 0.825
            [NoScaleOffset]_mainNormal("Main Normal", 2D) = "bump" {}
            [NoScaleOffset]_secondNormal("Second Normal", 2D) = "bump" {}
            _normalStrength("Normal Strength", Float) = 0.9
            _normalTiling("Normal Tiling", Float) = 1
            _normalSpeed("Normal Speed", Float) = 1
            _mainNormalDirection("Main Normal Direction", Vector) = (1, 0, 0, 0)
            _secondNormalDirection("Second Normal Direction", Vector) = (-1, 0, 0, 0)
            _amplitude("Wave amplitude", Float) = 1.5
            _waves("Waves", Float) = 1
            _wavesSpeed("Waves Speed", Float) = 0.2
            [Toggle]BOOLEAN_2D5E488208064DEDBE97E09FA59744E9("Waving", Float) = 1
        }
        SubShader
        {
            Tags
            {
                "RenderPipeline"="UniversalPipeline"
                "RenderType"="Transparent"
                "Queue"="Transparent"
            }
            Pass
            {
                Name "Universal Forward"
                Tags
                {
                    "LightMode" = "UniversalForward"
                }
    
                // Render State
                Cull Back
                Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
                ZTest LEqual
                ZWrite Off
    
                // Debug
                // <None>
    
                // --------------------------------------------------
                // Pass
    
                HLSLPROGRAM
    
                // Pragmas
                #pragma target 2.0
                #pragma only_renderers gles gles3
                #pragma multi_compile_instancing
                #pragma multi_compile_fog
                #pragma prefer_hlslcc gles
                #pragma vertex vert
                #pragma fragment frag
    
                // DotsInstancingOptions: <None>
                // HybridV1InjectedBuiltinProperties: <None>
    
                // Keywords
                #pragma multi_compile _ LIGHTMAP_ON
                #pragma multi_compile _ DIRLIGHTMAP_COMBINED
                #pragma multi_compile _ _MAIN_LIGHT_SHADOWS
                #pragma multi_compile _ _MAIN_LIGHT_SHADOWS_CASCADE
                #pragma multi_compile _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS _ADDITIONAL_OFF
                #pragma multi_compile _ _ADDITIONAL_LIGHT_SHADOWS
                #pragma multi_compile _ _SHADOWS_SOFT
                #pragma multi_compile _ _MIXED_LIGHTING_SUBTRACTIVE
                #pragma shader_feature_local _ BOOLEAN_2D5E488208064DEDBE97E09FA59744E9_ON
                
                #if defined(BOOLEAN_2D5E488208064DEDBE97E09FA59744E9_ON)
                    #define KEYWORD_PERMUTATION_0
                #else
                    #define KEYWORD_PERMUTATION_1
                #endif
                
    
                // Defines
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define _SURFACE_TYPE_TRANSPARENT 1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define _AlphaClip 1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define _NORMALMAP 1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define _NORMAL_DROPOFF_TS 1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define ATTRIBUTES_NEED_NORMAL
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define ATTRIBUTES_NEED_TANGENT
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define ATTRIBUTES_NEED_TEXCOORD0
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define ATTRIBUTES_NEED_TEXCOORD1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define VARYINGS_NEED_POSITION_WS
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define VARYINGS_NEED_NORMAL_WS
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define VARYINGS_NEED_TANGENT_WS
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define VARYINGS_NEED_TEXCOORD0
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define VARYINGS_NEED_VIEWDIRECTION_WS
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
            #endif
    
                #define FEATURES_GRAPH_VERTEX
                /* WARNING: $splice Could not find named fragment 'PassInstancing' */
                #define SHADERPASS SHADERPASS_FORWARD
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #define REQUIRE_DEPTH_TEXTURE
                #endif
                /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
    
                // Includes
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
    
                // --------------------------------------------------
                // Structs and Packing
    
                struct Attributes
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 positionOS : POSITION;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 normalOS : NORMAL;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 tangentOS : TANGENT;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 uv0 : TEXCOORD0;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 uv1 : TEXCOORD1;
                    #endif
                    #if UNITY_ANY_INSTANCING_ENABLED
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint instanceID : INSTANCEID_SEMANTIC;
                    #endif
                    #endif
                };
                struct Varyings
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 positionCS : SV_POSITION;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 positionWS;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 normalWS;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 tangentWS;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 texCoord0;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 viewDirectionWS;
                    #endif
                    #if defined(LIGHTMAP_ON)
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float2 lightmapUV;
                    #endif
                    #endif
                    #if !defined(LIGHTMAP_ON)
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 sh;
                    #endif
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 fogFactorAndVertexLight;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 shadowCoord;
                    #endif
                    #if UNITY_ANY_INSTANCING_ENABLED
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                    #endif
                };
                struct SurfaceDescriptionInputs
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 TangentSpaceNormal;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpacePosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 ScreenPosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 uv0;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 TimeParameters;
                    #endif
                };
                struct VertexDescriptionInputs
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 ObjectSpaceNormal;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpaceNormal;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 ObjectSpaceTangent;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpaceTangent;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 ObjectSpaceBiTangent;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpaceBiTangent;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 ObjectSpacePosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpacePosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 uv0;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 TimeParameters;
                    #endif
                };
                struct PackedVaryings
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 positionCS : SV_POSITION;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 interp0 : TEXCOORD0;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 interp1 : TEXCOORD1;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 interp2 : TEXCOORD2;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 interp3 : TEXCOORD3;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 interp4 : TEXCOORD4;
                    #endif
                    #if defined(LIGHTMAP_ON)
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float2 interp5 : TEXCOORD5;
                    #endif
                    #endif
                    #if !defined(LIGHTMAP_ON)
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 interp6 : TEXCOORD6;
                    #endif
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 interp7 : TEXCOORD7;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 interp8 : TEXCOORD8;
                    #endif
                    #if UNITY_ANY_INSTANCING_ENABLED
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                    #endif
                };
    
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                PackedVaryings PackVaryings (Varyings input)
                    {
                        PackedVaryings output;
                        output.positionCS = input.positionCS;
                        output.interp0.xyz =  input.positionWS;
                        output.interp1.xyz =  input.normalWS;
                        output.interp2.xyzw =  input.tangentWS;
                        output.interp3.xyzw =  input.texCoord0;
                        output.interp4.xyz =  input.viewDirectionWS;
                        #if defined(LIGHTMAP_ON)
                        output.interp5.xy =  input.lightmapUV;
                        #endif
                        #if !defined(LIGHTMAP_ON)
                        output.interp6.xyz =  input.sh;
                        #endif
                        output.interp7.xyzw =  input.fogFactorAndVertexLight;
                        output.interp8.xyzw =  input.shadowCoord;
                        #if UNITY_ANY_INSTANCING_ENABLED
                        output.instanceID = input.instanceID;
                        #endif
                        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                        #endif
                        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                        #endif
                        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                        output.cullFace = input.cullFace;
                        #endif
                        return output;
                    }
                    Varyings UnpackVaryings (PackedVaryings input)
                    {
                        Varyings output;
                        output.positionCS = input.positionCS;
                        output.positionWS = input.interp0.xyz;
                        output.normalWS = input.interp1.xyz;
                        output.tangentWS = input.interp2.xyzw;
                        output.texCoord0 = input.interp3.xyzw;
                        output.viewDirectionWS = input.interp4.xyz;
                        #if defined(LIGHTMAP_ON)
                        output.lightmapUV = input.interp5.xy;
                        #endif
                        #if !defined(LIGHTMAP_ON)
                        output.sh = input.interp6.xyz;
                        #endif
                        output.fogFactorAndVertexLight = input.interp7.xyzw;
                        output.shadowCoord = input.interp8.xyzw;
                        #if UNITY_ANY_INSTANCING_ENABLED
                        output.instanceID = input.instanceID;
                        #endif
                        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                        #endif
                        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                        #endif
                        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                        output.cullFace = input.cullFace;
                        #endif
                        return output;
                    }
                #endif
    
                // --------------------------------------------------
                // Graph
    
                // Graph Properties
                CBUFFER_START(UnityPerMaterial)
                float _depth;
                float _depthStrength;
                float4 _deepWaterColor;
                float4 _shallowWaterColor;
                float _smoothness;
                float _normalStrength;
                float _normalTiling;
                float _normalSpeed;
                float3 _mainNormalDirection;
                float3 _secondNormalDirection;
                float _amplitude;
                float _waves;
                float _wavesSpeed;
                CBUFFER_END
                TEXTURE2D(_mainNormal); SAMPLER(sampler_mainNormal); float4 _mainNormal_TexelSize;
                TEXTURE2D(_secondNormal); SAMPLER(sampler_secondNormal); float4 _secondNormal_TexelSize;
                SAMPLER(_SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_19fa380f103d42a49d00ac60250e471c_Sampler_3_Linear_Repeat);
    
                // Graph Functions
                
                void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A / B;
                }
                
                void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                {
                    Out = UV * Tiling + Offset;
                }
                
                
                float2 Unity_GradientNoise_Dir_float(float2 p)
                {
                    // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
                    p = p % 289;
                    // need full precision, otherwise half overflows when p > 1
                    float x = float(34 * p.x + 1) * p.x % 289 + p.y;
                    x = (34 * x + 1) * x % 289;
                    x = frac(x / 41) * 2 - 1;
                    return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
                }
                
                void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
                { 
                    float2 p = UV * Scale;
                    float2 ip = floor(p);
                    float2 fp = frac(p);
                    float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
                    float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
                    float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
                    float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
                    fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
                    Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
                }
                
                void Unity_Add_float(float A, float B, out float Out)
                {
                    Out = A + B;
                }
                
                void Unity_Divide_float(float A, float B, out float Out)
                {
                    Out = A / B;
                }
                
                void Unity_Subtract_float(float A, float B, out float Out)
                {
                    Out = A - B;
                }
                
                void Unity_Multiply_float(float A, float B, out float Out)
                {
                    Out = A * B;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_SceneDepth_Linear01_float(float4 UV, out float Out)
                {
                    Out = Linear01Depth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
                }
                
                void Unity_Clamp_float(float In, float Min, float Max, out float Out)
                {
                    Out = clamp(In, Min, Max);
                }
                
                void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
                {
                    Out = lerp(A, B, T);
                }
                
                void Unity_Add_float4(float4 A, float4 B, out float4 Out)
                {
                    Out = A + B;
                }
                
                void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
                {
                    Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
                }
    
                // Graph Vertex
                struct VertexDescription
                {
                    float3 Position;
                    float3 Normal;
                    float3 Tangent;
                };
                
                VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                {
                    VertexDescription description = (VertexDescription)0;
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Split_ff0fd34a61f44fd7ae2f222441749bd9_R_1 = IN.WorldSpacePosition[0];
                    float _Split_ff0fd34a61f44fd7ae2f222441749bd9_G_2 = IN.WorldSpacePosition[1];
                    float _Split_ff0fd34a61f44fd7ae2f222441749bd9_B_3 = IN.WorldSpacePosition[2];
                    float _Split_ff0fd34a61f44fd7ae2f222441749bd9_A_4 = 0;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_f4af681ed89a4a3d8c81333e9f8b562d_Out_0 = _waves;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Property_49ef859bb89c4a8288c9eb1583334fde_Out_0 = _mainNormalDirection;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_992df1e5e71b4479bbb5a25e534d8861_Out_2;
                    Unity_Multiply_float((IN.TimeParameters.x.xxx), _Property_49ef859bb89c4a8288c9eb1583334fde_Out_0, _Multiply_992df1e5e71b4479bbb5a25e534d8861_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Vector1_60e9a38039a843989ca21ba08ba76bd7_Out_0 = 5;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Divide_eb274efe27a64e71ba9baa084548bb6c_Out_2;
                    Unity_Divide_float3(_Multiply_992df1e5e71b4479bbb5a25e534d8861_Out_2, (_Vector1_60e9a38039a843989ca21ba08ba76bd7_Out_0.xxx), _Divide_eb274efe27a64e71ba9baa084548bb6c_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_92f37cd5909d40809e2b672d1636bd54_Out_0 = _wavesSpeed;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_afb804d1277148d7b992f652bb14e3be_Out_2;
                    Unity_Multiply_float(_Divide_eb274efe27a64e71ba9baa084548bb6c_Out_2, (_Property_92f37cd5909d40809e2b672d1636bd54_Out_0.xxx), _Multiply_afb804d1277148d7b992f652bb14e3be_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float2 _TilingAndOffset_05baded2421248cd9222b83233309dcb_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, (_Property_f4af681ed89a4a3d8c81333e9f8b562d_Out_0.xx), (_Multiply_afb804d1277148d7b992f652bb14e3be_Out_2.xy), _TilingAndOffset_05baded2421248cd9222b83233309dcb_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _GradientNoise_5b5f40a249b347c9be3b4afc6d0ed3ad_Out_2;
                    Unity_GradientNoise_float(_TilingAndOffset_05baded2421248cd9222b83233309dcb_Out_3, 10, _GradientNoise_5b5f40a249b347c9be3b4afc6d0ed3ad_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Property_666f9a531b564538acc376057bc6caa9_Out_0 = _secondNormalDirection;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_118898149cbd4850b0807b9467ed73b4_Out_2;
                    Unity_Multiply_float((IN.TimeParameters.x.xxx), _Property_666f9a531b564538acc376057bc6caa9_Out_0, _Multiply_118898149cbd4850b0807b9467ed73b4_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Vector1_ea96af95fe4f4961ad8bfc89f5bc9a03_Out_0 = 5;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Divide_b7c139d64ea9401fbda3a903c9fd1bf6_Out_2;
                    Unity_Divide_float3(_Multiply_118898149cbd4850b0807b9467ed73b4_Out_2, (_Vector1_ea96af95fe4f4961ad8bfc89f5bc9a03_Out_0.xxx), _Divide_b7c139d64ea9401fbda3a903c9fd1bf6_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_6199970682ac4c9c947732b8aa1e32b0_Out_2;
                    Unity_Multiply_float(_Divide_b7c139d64ea9401fbda3a903c9fd1bf6_Out_2, (_Property_92f37cd5909d40809e2b672d1636bd54_Out_0.xxx), _Multiply_6199970682ac4c9c947732b8aa1e32b0_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float2 _TilingAndOffset_2d869c568f8c4bd1935e9e1a5d383ff4_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, (_Property_f4af681ed89a4a3d8c81333e9f8b562d_Out_0.xx), (_Multiply_6199970682ac4c9c947732b8aa1e32b0_Out_2.xy), _TilingAndOffset_2d869c568f8c4bd1935e9e1a5d383ff4_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _GradientNoise_7d50ab18cca7435cbe45ace0410a84c7_Out_2;
                    Unity_GradientNoise_float(_TilingAndOffset_2d869c568f8c4bd1935e9e1a5d383ff4_Out_3, 10, _GradientNoise_7d50ab18cca7435cbe45ace0410a84c7_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Add_3ab7d42c644a4df381d663f07b7ab1e9_Out_2;
                    Unity_Add_float(_GradientNoise_5b5f40a249b347c9be3b4afc6d0ed3ad_Out_2, _GradientNoise_7d50ab18cca7435cbe45ace0410a84c7_Out_2, _Add_3ab7d42c644a4df381d663f07b7ab1e9_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Divide_cefb6bacdd4e476ea8103edefe43f584_Out_2;
                    Unity_Divide_float(_Add_3ab7d42c644a4df381d663f07b7ab1e9_Out_2, 2, _Divide_cefb6bacdd4e476ea8103edefe43f584_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Subtract_4da7b6862bcc45eca57cbd26b806eaf0_Out_2;
                    Unity_Subtract_float(_Divide_cefb6bacdd4e476ea8103edefe43f584_Out_2, 0.61, _Subtract_4da7b6862bcc45eca57cbd26b806eaf0_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_ce933f1cb0934b47a86069374aea82d8_Out_0 = _amplitude;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Multiply_fc80491e653843f7b95b7d963584d21d_Out_2;
                    Unity_Multiply_float(_Subtract_4da7b6862bcc45eca57cbd26b806eaf0_Out_2, _Property_ce933f1cb0934b47a86069374aea82d8_Out_0, _Multiply_fc80491e653843f7b95b7d963584d21d_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Combine_4394e5327dea4ebda9c6b40c020e0721_RGBA_4;
                    float3 _Combine_4394e5327dea4ebda9c6b40c020e0721_RGB_5;
                    float2 _Combine_4394e5327dea4ebda9c6b40c020e0721_RG_6;
                    Unity_Combine_float(_Split_ff0fd34a61f44fd7ae2f222441749bd9_R_1, _Multiply_fc80491e653843f7b95b7d963584d21d_Out_2, _Split_ff0fd34a61f44fd7ae2f222441749bd9_B_3, 0, _Combine_4394e5327dea4ebda9c6b40c020e0721_RGBA_4, _Combine_4394e5327dea4ebda9c6b40c020e0721_RGB_5, _Combine_4394e5327dea4ebda9c6b40c020e0721_RG_6);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Transform_5f6d055972de4e69871e05659dc0cf87_Out_1 = TransformWorldToObject(_Combine_4394e5327dea4ebda9c6b40c020e0721_RGB_5.xyz);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Combine_989bd6296fa44c898dce3b24fde18c9d_RGBA_4;
                    float3 _Combine_989bd6296fa44c898dce3b24fde18c9d_RGB_5;
                    float2 _Combine_989bd6296fa44c898dce3b24fde18c9d_RG_6;
                    Unity_Combine_float(_Split_ff0fd34a61f44fd7ae2f222441749bd9_R_1, _Split_ff0fd34a61f44fd7ae2f222441749bd9_G_2, _Split_ff0fd34a61f44fd7ae2f222441749bd9_B_3, 0, _Combine_989bd6296fa44c898dce3b24fde18c9d_RGBA_4, _Combine_989bd6296fa44c898dce3b24fde18c9d_RGB_5, _Combine_989bd6296fa44c898dce3b24fde18c9d_RG_6);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    #if defined(BOOLEAN_2D5E488208064DEDBE97E09FA59744E9_ON)
                    float3 _Waving_e9c7407f61464da88e74e85183ca2065_Out_0 = _Transform_5f6d055972de4e69871e05659dc0cf87_Out_1;
                    #else
                    float3 _Waving_e9c7407f61464da88e74e85183ca2065_Out_0 = _Combine_989bd6296fa44c898dce3b24fde18c9d_RGB_5;
                    #endif
                    #endif
                    description.Position = _Waving_e9c7407f61464da88e74e85183ca2065_Out_0;
                    description.Normal = IN.ObjectSpaceNormal;
                    description.Tangent = IN.ObjectSpaceTangent;
                    return description;
                }
    
                // Graph Pixel
                struct SurfaceDescription
                {
                    float3 BaseColor;
                    float3 NormalTS;
                    float3 Emission;
                    float Metallic;
                    float Smoothness;
                    float Occlusion;
                    float Alpha;
                    float AlphaClipThreshold;
                };
                
                SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                {
                    SurfaceDescription surface = (SurfaceDescription)0;
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Property_cd262e3649c94d36ac1a6035934c82ba_Out_0 = _shallowWaterColor;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Property_c08d4525fbf641d78eb168f9e6c77374_Out_0 = _deepWaterColor;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _SceneDepth_ff2814420f634b6c9006b17db1b0db86_Out_1;
                    Unity_SceneDepth_Linear01_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_ff2814420f634b6c9006b17db1b0db86_Out_1);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Multiply_7fe029570de94c259af598c01f1e9fc7_Out_2;
                    Unity_Multiply_float(_SceneDepth_ff2814420f634b6c9006b17db1b0db86_Out_1, _ProjectionParams.z, _Multiply_7fe029570de94c259af598c01f1e9fc7_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_69b3cbbc42e345ba9fcd9de510b5e2d7_Out_0 = _depth;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0 = IN.ScreenPosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Split_4da6c10dd6e44537a1e2021901925b9e_R_1 = _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0[0];
                    float _Split_4da6c10dd6e44537a1e2021901925b9e_G_2 = _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0[1];
                    float _Split_4da6c10dd6e44537a1e2021901925b9e_B_3 = _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0[2];
                    float _Split_4da6c10dd6e44537a1e2021901925b9e_A_4 = _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0[3];
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Add_5516261d5322477cbf6c851a3128394f_Out_2;
                    Unity_Add_float(_Property_69b3cbbc42e345ba9fcd9de510b5e2d7_Out_0, _Split_4da6c10dd6e44537a1e2021901925b9e_A_4, _Add_5516261d5322477cbf6c851a3128394f_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Subtract_f153dba44eeb4c808ffd45ea4a4f742e_Out_2;
                    Unity_Subtract_float(_Multiply_7fe029570de94c259af598c01f1e9fc7_Out_2, _Add_5516261d5322477cbf6c851a3128394f_Out_2, _Subtract_f153dba44eeb4c808ffd45ea4a4f742e_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_3b327dff25184e83be825e3db1854a26_Out_0 = _depthStrength;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Multiply_bcf5cd29cecf4b4f97083346027d340a_Out_2;
                    Unity_Multiply_float(_Subtract_f153dba44eeb4c808ffd45ea4a4f742e_Out_2, _Property_3b327dff25184e83be825e3db1854a26_Out_0, _Multiply_bcf5cd29cecf4b4f97083346027d340a_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Clamp_07516fbacac148a2ab07ae8f0615108e_Out_3;
                    Unity_Clamp_float(_Multiply_bcf5cd29cecf4b4f97083346027d340a_Out_2, 0, 1, _Clamp_07516fbacac148a2ab07ae8f0615108e_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3;
                    Unity_Lerp_float4(_Property_cd262e3649c94d36ac1a6035934c82ba_Out_0, _Property_c08d4525fbf641d78eb168f9e6c77374_Out_0, (_Clamp_07516fbacac148a2ab07ae8f0615108e_Out_3.xxxx), _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_5482a63064fe4dc986c10d26e2a866c9_Out_0 = _normalTiling;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Property_b18edaa63f6640f1abc5e1c084fa03d7_Out_0 = _mainNormalDirection;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_26a9c6abd5cb40b5bea80cc2e337259f_Out_2;
                    Unity_Multiply_float((IN.TimeParameters.x.xxx), _Property_b18edaa63f6640f1abc5e1c084fa03d7_Out_0, _Multiply_26a9c6abd5cb40b5bea80cc2e337259f_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Vector1_cce353cff4d443cbad9f0028192af8a7_Out_0 = 5;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Divide_436ce3df6a4b4ab384b5f9e6fde7cbff_Out_2;
                    Unity_Divide_float3(_Multiply_26a9c6abd5cb40b5bea80cc2e337259f_Out_2, (_Vector1_cce353cff4d443cbad9f0028192af8a7_Out_0.xxx), _Divide_436ce3df6a4b4ab384b5f9e6fde7cbff_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_a100da2d1db545d3bdd6a98d6c3338b4_Out_0 = _normalSpeed;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_52a0ffd9cfff4dbca39fd96e162d6f38_Out_2;
                    Unity_Multiply_float(_Divide_436ce3df6a4b4ab384b5f9e6fde7cbff_Out_2, (_Property_a100da2d1db545d3bdd6a98d6c3338b4_Out_0.xxx), _Multiply_52a0ffd9cfff4dbca39fd96e162d6f38_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float2 _TilingAndOffset_d7789ee50db3482f9d54ada635414804_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, (_Property_5482a63064fe4dc986c10d26e2a866c9_Out_0.xx), (_Multiply_52a0ffd9cfff4dbca39fd96e162d6f38_Out_2.xy), _TilingAndOffset_d7789ee50db3482f9d54ada635414804_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_RGBA_0 = SAMPLE_TEXTURE2D(_mainNormal, sampler_mainNormal, _TilingAndOffset_d7789ee50db3482f9d54ada635414804_Out_3);
                    _SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_RGBA_0);
                    float _SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_R_4 = _SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_RGBA_0.r;
                    float _SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_G_5 = _SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_RGBA_0.g;
                    float _SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_B_6 = _SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_RGBA_0.b;
                    float _SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_A_7 = _SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_RGBA_0.a;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Property_dbda2894373e42498a86446296d428f0_Out_0 = _secondNormalDirection;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_69c904868d6240009395971af991ea70_Out_2;
                    Unity_Multiply_float((IN.TimeParameters.x.xxx), _Property_dbda2894373e42498a86446296d428f0_Out_0, _Multiply_69c904868d6240009395971af991ea70_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Vector1_86da2039a4f840cba31ad8417eedfdbe_Out_0 = 5;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Divide_7e931fd752a14839ac903c8c1f23fa8b_Out_2;
                    Unity_Divide_float3(_Multiply_69c904868d6240009395971af991ea70_Out_2, (_Vector1_86da2039a4f840cba31ad8417eedfdbe_Out_0.xxx), _Divide_7e931fd752a14839ac903c8c1f23fa8b_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_9b564bc582834a84b02772947489b2ee_Out_0 = _normalSpeed;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_a0a0b6832fcd46c0badaac4e7758d9af_Out_2;
                    Unity_Multiply_float(_Divide_7e931fd752a14839ac903c8c1f23fa8b_Out_2, (_Property_9b564bc582834a84b02772947489b2ee_Out_0.xxx), _Multiply_a0a0b6832fcd46c0badaac4e7758d9af_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float2 _TilingAndOffset_248c7474eeba4e7b9f1353cc429027df_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, (_Property_5482a63064fe4dc986c10d26e2a866c9_Out_0.xx), (_Multiply_a0a0b6832fcd46c0badaac4e7758d9af_Out_2.xy), _TilingAndOffset_248c7474eeba4e7b9f1353cc429027df_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _SampleTexture2D_19fa380f103d42a49d00ac60250e471c_RGBA_0 = SAMPLE_TEXTURE2D(_secondNormal, sampler_secondNormal, _TilingAndOffset_248c7474eeba4e7b9f1353cc429027df_Out_3);
                    _SampleTexture2D_19fa380f103d42a49d00ac60250e471c_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_19fa380f103d42a49d00ac60250e471c_RGBA_0);
                    float _SampleTexture2D_19fa380f103d42a49d00ac60250e471c_R_4 = _SampleTexture2D_19fa380f103d42a49d00ac60250e471c_RGBA_0.r;
                    float _SampleTexture2D_19fa380f103d42a49d00ac60250e471c_G_5 = _SampleTexture2D_19fa380f103d42a49d00ac60250e471c_RGBA_0.g;
                    float _SampleTexture2D_19fa380f103d42a49d00ac60250e471c_B_6 = _SampleTexture2D_19fa380f103d42a49d00ac60250e471c_RGBA_0.b;
                    float _SampleTexture2D_19fa380f103d42a49d00ac60250e471c_A_7 = _SampleTexture2D_19fa380f103d42a49d00ac60250e471c_RGBA_0.a;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Add_848875f285c84daf9d7cce6829511404_Out_2;
                    Unity_Add_float4(_SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_RGBA_0, _SampleTexture2D_19fa380f103d42a49d00ac60250e471c_RGBA_0, _Add_848875f285c84daf9d7cce6829511404_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_8a702d79c0774b35aa6e24f8f95f098e_Out_0 = _normalStrength;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _NormalStrength_51ceaf799ace4a3abbc7030d015375d7_Out_2;
                    Unity_NormalStrength_float((_Add_848875f285c84daf9d7cce6829511404_Out_2.xyz), _Property_8a702d79c0774b35aa6e24f8f95f098e_Out_0, _NormalStrength_51ceaf799ace4a3abbc7030d015375d7_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_9dbd6cc5b1314dceb76f85fbbb09dc7d_Out_0 = _smoothness;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Split_5dc8f38583ee40c19b6f09138a95e012_R_1 = _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3[0];
                    float _Split_5dc8f38583ee40c19b6f09138a95e012_G_2 = _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3[1];
                    float _Split_5dc8f38583ee40c19b6f09138a95e012_B_3 = _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3[2];
                    float _Split_5dc8f38583ee40c19b6f09138a95e012_A_4 = _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3[3];
                    #endif
                    surface.BaseColor = (_Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3.xyz);
                    surface.NormalTS = _NormalStrength_51ceaf799ace4a3abbc7030d015375d7_Out_2;
                    surface.Emission = float3(0, 0, 0);
                    surface.Metallic = 0;
                    surface.Smoothness = _Property_9dbd6cc5b1314dceb76f85fbbb09dc7d_Out_0;
                    surface.Occlusion = 1;
                    surface.Alpha = _Split_5dc8f38583ee40c19b6f09138a95e012_A_4;
                    surface.AlphaClipThreshold = 0;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ObjectSpaceNormal =           input.normalOS;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ObjectSpaceTangent =          input.tangentOS;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ObjectSpacePosition =         input.positionOS;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpacePosition =          TransformObjectToWorld(input.positionOS);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.uv0 =                         input.uv0;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.TimeParameters =              _TimeParameters.xyz;
                #endif
                
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                #endif
                
                
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpacePosition =          input.positionWS;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.uv0 =                         input.texCoord0;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.TimeParameters =              _TimeParameters.xyz; // This is mainly for LW as HD overwrite this value
                #endif
                
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
                #else
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                #endif
                #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                
                    return output;
                }
                
    
                // --------------------------------------------------
                // Main
    
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBRForwardPass.hlsl"
    
                ENDHLSL
            }
            Pass
            {
                Name "Universal GBuffer"
                Tags
                {
                    "LightMode" = "UniversalGBuffer"
                }
    
                // Render State
                Cull Back
                Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
                ZTest LEqual
                ZWrite Off
    
                // Debug
                // <None>
    
                // --------------------------------------------------
                // Pass
    
                HLSLPROGRAM
    
                // Pragmas
                #pragma target 2.0
                #pragma only_renderers gles gles3
                #pragma multi_compile_instancing
                #pragma multi_compile_fog
                #pragma prefer_hlslcc gles
                #pragma vertex vert
                #pragma fragment frag
    
                // DotsInstancingOptions: <None>
                // HybridV1InjectedBuiltinProperties: <None>
    
                // Keywords
                #pragma multi_compile _ LIGHTMAP_ON
                #pragma multi_compile _ DIRLIGHTMAP_COMBINED
                #pragma multi_compile _ _MAIN_LIGHT_SHADOWS
                #pragma multi_compile _ _MAIN_LIGHT_SHADOWS_CASCADE
                #pragma multi_compile _ _SHADOWS_SOFT
                #pragma multi_compile _ _MIXED_LIGHTING_SUBTRACTIVE
                #pragma multi_compile _ _GBUFFER_NORMALS_OCT
                #pragma shader_feature_local _ BOOLEAN_2D5E488208064DEDBE97E09FA59744E9_ON
                
                #if defined(BOOLEAN_2D5E488208064DEDBE97E09FA59744E9_ON)
                    #define KEYWORD_PERMUTATION_0
                #else
                    #define KEYWORD_PERMUTATION_1
                #endif
                
    
                // Defines
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define _SURFACE_TYPE_TRANSPARENT 1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define _AlphaClip 1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define _NORMALMAP 1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define _NORMAL_DROPOFF_TS 1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define ATTRIBUTES_NEED_NORMAL
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define ATTRIBUTES_NEED_TANGENT
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define ATTRIBUTES_NEED_TEXCOORD0
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define ATTRIBUTES_NEED_TEXCOORD1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define VARYINGS_NEED_POSITION_WS
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define VARYINGS_NEED_NORMAL_WS
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define VARYINGS_NEED_TANGENT_WS
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define VARYINGS_NEED_TEXCOORD0
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define VARYINGS_NEED_VIEWDIRECTION_WS
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
            #endif
    
                #define FEATURES_GRAPH_VERTEX
                /* WARNING: $splice Could not find named fragment 'PassInstancing' */
                #define SHADERPASS SHADERPASS_GBUFFER
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #define REQUIRE_DEPTH_TEXTURE
                #endif
                /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
    
                // Includes
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
    
                // --------------------------------------------------
                // Structs and Packing
    
                struct Attributes
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 positionOS : POSITION;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 normalOS : NORMAL;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 tangentOS : TANGENT;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 uv0 : TEXCOORD0;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 uv1 : TEXCOORD1;
                    #endif
                    #if UNITY_ANY_INSTANCING_ENABLED
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint instanceID : INSTANCEID_SEMANTIC;
                    #endif
                    #endif
                };
                struct Varyings
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 positionCS : SV_POSITION;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 positionWS;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 normalWS;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 tangentWS;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 texCoord0;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 viewDirectionWS;
                    #endif
                    #if defined(LIGHTMAP_ON)
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float2 lightmapUV;
                    #endif
                    #endif
                    #if !defined(LIGHTMAP_ON)
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 sh;
                    #endif
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 fogFactorAndVertexLight;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 shadowCoord;
                    #endif
                    #if UNITY_ANY_INSTANCING_ENABLED
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                    #endif
                };
                struct SurfaceDescriptionInputs
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 TangentSpaceNormal;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpacePosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 ScreenPosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 uv0;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 TimeParameters;
                    #endif
                };
                struct VertexDescriptionInputs
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 ObjectSpaceNormal;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpaceNormal;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 ObjectSpaceTangent;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpaceTangent;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 ObjectSpaceBiTangent;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpaceBiTangent;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 ObjectSpacePosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpacePosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 uv0;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 TimeParameters;
                    #endif
                };
                struct PackedVaryings
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 positionCS : SV_POSITION;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 interp0 : TEXCOORD0;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 interp1 : TEXCOORD1;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 interp2 : TEXCOORD2;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 interp3 : TEXCOORD3;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 interp4 : TEXCOORD4;
                    #endif
                    #if defined(LIGHTMAP_ON)
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float2 interp5 : TEXCOORD5;
                    #endif
                    #endif
                    #if !defined(LIGHTMAP_ON)
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 interp6 : TEXCOORD6;
                    #endif
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 interp7 : TEXCOORD7;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 interp8 : TEXCOORD8;
                    #endif
                    #if UNITY_ANY_INSTANCING_ENABLED
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                    #endif
                };
    
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                PackedVaryings PackVaryings (Varyings input)
                    {
                        PackedVaryings output;
                        output.positionCS = input.positionCS;
                        output.interp0.xyz =  input.positionWS;
                        output.interp1.xyz =  input.normalWS;
                        output.interp2.xyzw =  input.tangentWS;
                        output.interp3.xyzw =  input.texCoord0;
                        output.interp4.xyz =  input.viewDirectionWS;
                        #if defined(LIGHTMAP_ON)
                        output.interp5.xy =  input.lightmapUV;
                        #endif
                        #if !defined(LIGHTMAP_ON)
                        output.interp6.xyz =  input.sh;
                        #endif
                        output.interp7.xyzw =  input.fogFactorAndVertexLight;
                        output.interp8.xyzw =  input.shadowCoord;
                        #if UNITY_ANY_INSTANCING_ENABLED
                        output.instanceID = input.instanceID;
                        #endif
                        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                        #endif
                        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                        #endif
                        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                        output.cullFace = input.cullFace;
                        #endif
                        return output;
                    }
                    Varyings UnpackVaryings (PackedVaryings input)
                    {
                        Varyings output;
                        output.positionCS = input.positionCS;
                        output.positionWS = input.interp0.xyz;
                        output.normalWS = input.interp1.xyz;
                        output.tangentWS = input.interp2.xyzw;
                        output.texCoord0 = input.interp3.xyzw;
                        output.viewDirectionWS = input.interp4.xyz;
                        #if defined(LIGHTMAP_ON)
                        output.lightmapUV = input.interp5.xy;
                        #endif
                        #if !defined(LIGHTMAP_ON)
                        output.sh = input.interp6.xyz;
                        #endif
                        output.fogFactorAndVertexLight = input.interp7.xyzw;
                        output.shadowCoord = input.interp8.xyzw;
                        #if UNITY_ANY_INSTANCING_ENABLED
                        output.instanceID = input.instanceID;
                        #endif
                        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                        #endif
                        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                        #endif
                        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                        output.cullFace = input.cullFace;
                        #endif
                        return output;
                    }
                #endif
    
                // --------------------------------------------------
                // Graph
    
                // Graph Properties
                CBUFFER_START(UnityPerMaterial)
                float _depth;
                float _depthStrength;
                float4 _deepWaterColor;
                float4 _shallowWaterColor;
                float _smoothness;
                float _normalStrength;
                float _normalTiling;
                float _normalSpeed;
                float3 _mainNormalDirection;
                float3 _secondNormalDirection;
                float _amplitude;
                float _waves;
                float _wavesSpeed;
                CBUFFER_END
                TEXTURE2D(_mainNormal); SAMPLER(sampler_mainNormal); float4 _mainNormal_TexelSize;
                TEXTURE2D(_secondNormal); SAMPLER(sampler_secondNormal); float4 _secondNormal_TexelSize;
                SAMPLER(_SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_19fa380f103d42a49d00ac60250e471c_Sampler_3_Linear_Repeat);
    
                // Graph Functions
                
                void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A / B;
                }
                
                void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                {
                    Out = UV * Tiling + Offset;
                }
                
                
                float2 Unity_GradientNoise_Dir_float(float2 p)
                {
                    // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
                    p = p % 289;
                    // need full precision, otherwise half overflows when p > 1
                    float x = float(34 * p.x + 1) * p.x % 289 + p.y;
                    x = (34 * x + 1) * x % 289;
                    x = frac(x / 41) * 2 - 1;
                    return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
                }
                
                void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
                { 
                    float2 p = UV * Scale;
                    float2 ip = floor(p);
                    float2 fp = frac(p);
                    float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
                    float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
                    float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
                    float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
                    fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
                    Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
                }
                
                void Unity_Add_float(float A, float B, out float Out)
                {
                    Out = A + B;
                }
                
                void Unity_Divide_float(float A, float B, out float Out)
                {
                    Out = A / B;
                }
                
                void Unity_Subtract_float(float A, float B, out float Out)
                {
                    Out = A - B;
                }
                
                void Unity_Multiply_float(float A, float B, out float Out)
                {
                    Out = A * B;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_SceneDepth_Linear01_float(float4 UV, out float Out)
                {
                    Out = Linear01Depth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
                }
                
                void Unity_Clamp_float(float In, float Min, float Max, out float Out)
                {
                    Out = clamp(In, Min, Max);
                }
                
                void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
                {
                    Out = lerp(A, B, T);
                }
                
                void Unity_Add_float4(float4 A, float4 B, out float4 Out)
                {
                    Out = A + B;
                }
                
                void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
                {
                    Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
                }
    
                // Graph Vertex
                struct VertexDescription
                {
                    float3 Position;
                    float3 Normal;
                    float3 Tangent;
                };
                
                VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                {
                    VertexDescription description = (VertexDescription)0;
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Split_ff0fd34a61f44fd7ae2f222441749bd9_R_1 = IN.WorldSpacePosition[0];
                    float _Split_ff0fd34a61f44fd7ae2f222441749bd9_G_2 = IN.WorldSpacePosition[1];
                    float _Split_ff0fd34a61f44fd7ae2f222441749bd9_B_3 = IN.WorldSpacePosition[2];
                    float _Split_ff0fd34a61f44fd7ae2f222441749bd9_A_4 = 0;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_f4af681ed89a4a3d8c81333e9f8b562d_Out_0 = _waves;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Property_49ef859bb89c4a8288c9eb1583334fde_Out_0 = _mainNormalDirection;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_992df1e5e71b4479bbb5a25e534d8861_Out_2;
                    Unity_Multiply_float((IN.TimeParameters.x.xxx), _Property_49ef859bb89c4a8288c9eb1583334fde_Out_0, _Multiply_992df1e5e71b4479bbb5a25e534d8861_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Vector1_60e9a38039a843989ca21ba08ba76bd7_Out_0 = 5;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Divide_eb274efe27a64e71ba9baa084548bb6c_Out_2;
                    Unity_Divide_float3(_Multiply_992df1e5e71b4479bbb5a25e534d8861_Out_2, (_Vector1_60e9a38039a843989ca21ba08ba76bd7_Out_0.xxx), _Divide_eb274efe27a64e71ba9baa084548bb6c_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_92f37cd5909d40809e2b672d1636bd54_Out_0 = _wavesSpeed;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_afb804d1277148d7b992f652bb14e3be_Out_2;
                    Unity_Multiply_float(_Divide_eb274efe27a64e71ba9baa084548bb6c_Out_2, (_Property_92f37cd5909d40809e2b672d1636bd54_Out_0.xxx), _Multiply_afb804d1277148d7b992f652bb14e3be_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float2 _TilingAndOffset_05baded2421248cd9222b83233309dcb_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, (_Property_f4af681ed89a4a3d8c81333e9f8b562d_Out_0.xx), (_Multiply_afb804d1277148d7b992f652bb14e3be_Out_2.xy), _TilingAndOffset_05baded2421248cd9222b83233309dcb_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _GradientNoise_5b5f40a249b347c9be3b4afc6d0ed3ad_Out_2;
                    Unity_GradientNoise_float(_TilingAndOffset_05baded2421248cd9222b83233309dcb_Out_3, 10, _GradientNoise_5b5f40a249b347c9be3b4afc6d0ed3ad_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Property_666f9a531b564538acc376057bc6caa9_Out_0 = _secondNormalDirection;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_118898149cbd4850b0807b9467ed73b4_Out_2;
                    Unity_Multiply_float((IN.TimeParameters.x.xxx), _Property_666f9a531b564538acc376057bc6caa9_Out_0, _Multiply_118898149cbd4850b0807b9467ed73b4_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Vector1_ea96af95fe4f4961ad8bfc89f5bc9a03_Out_0 = 5;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Divide_b7c139d64ea9401fbda3a903c9fd1bf6_Out_2;
                    Unity_Divide_float3(_Multiply_118898149cbd4850b0807b9467ed73b4_Out_2, (_Vector1_ea96af95fe4f4961ad8bfc89f5bc9a03_Out_0.xxx), _Divide_b7c139d64ea9401fbda3a903c9fd1bf6_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_6199970682ac4c9c947732b8aa1e32b0_Out_2;
                    Unity_Multiply_float(_Divide_b7c139d64ea9401fbda3a903c9fd1bf6_Out_2, (_Property_92f37cd5909d40809e2b672d1636bd54_Out_0.xxx), _Multiply_6199970682ac4c9c947732b8aa1e32b0_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float2 _TilingAndOffset_2d869c568f8c4bd1935e9e1a5d383ff4_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, (_Property_f4af681ed89a4a3d8c81333e9f8b562d_Out_0.xx), (_Multiply_6199970682ac4c9c947732b8aa1e32b0_Out_2.xy), _TilingAndOffset_2d869c568f8c4bd1935e9e1a5d383ff4_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _GradientNoise_7d50ab18cca7435cbe45ace0410a84c7_Out_2;
                    Unity_GradientNoise_float(_TilingAndOffset_2d869c568f8c4bd1935e9e1a5d383ff4_Out_3, 10, _GradientNoise_7d50ab18cca7435cbe45ace0410a84c7_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Add_3ab7d42c644a4df381d663f07b7ab1e9_Out_2;
                    Unity_Add_float(_GradientNoise_5b5f40a249b347c9be3b4afc6d0ed3ad_Out_2, _GradientNoise_7d50ab18cca7435cbe45ace0410a84c7_Out_2, _Add_3ab7d42c644a4df381d663f07b7ab1e9_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Divide_cefb6bacdd4e476ea8103edefe43f584_Out_2;
                    Unity_Divide_float(_Add_3ab7d42c644a4df381d663f07b7ab1e9_Out_2, 2, _Divide_cefb6bacdd4e476ea8103edefe43f584_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Subtract_4da7b6862bcc45eca57cbd26b806eaf0_Out_2;
                    Unity_Subtract_float(_Divide_cefb6bacdd4e476ea8103edefe43f584_Out_2, 0.61, _Subtract_4da7b6862bcc45eca57cbd26b806eaf0_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_ce933f1cb0934b47a86069374aea82d8_Out_0 = _amplitude;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Multiply_fc80491e653843f7b95b7d963584d21d_Out_2;
                    Unity_Multiply_float(_Subtract_4da7b6862bcc45eca57cbd26b806eaf0_Out_2, _Property_ce933f1cb0934b47a86069374aea82d8_Out_0, _Multiply_fc80491e653843f7b95b7d963584d21d_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Combine_4394e5327dea4ebda9c6b40c020e0721_RGBA_4;
                    float3 _Combine_4394e5327dea4ebda9c6b40c020e0721_RGB_5;
                    float2 _Combine_4394e5327dea4ebda9c6b40c020e0721_RG_6;
                    Unity_Combine_float(_Split_ff0fd34a61f44fd7ae2f222441749bd9_R_1, _Multiply_fc80491e653843f7b95b7d963584d21d_Out_2, _Split_ff0fd34a61f44fd7ae2f222441749bd9_B_3, 0, _Combine_4394e5327dea4ebda9c6b40c020e0721_RGBA_4, _Combine_4394e5327dea4ebda9c6b40c020e0721_RGB_5, _Combine_4394e5327dea4ebda9c6b40c020e0721_RG_6);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Transform_5f6d055972de4e69871e05659dc0cf87_Out_1 = TransformWorldToObject(_Combine_4394e5327dea4ebda9c6b40c020e0721_RGB_5.xyz);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Combine_989bd6296fa44c898dce3b24fde18c9d_RGBA_4;
                    float3 _Combine_989bd6296fa44c898dce3b24fde18c9d_RGB_5;
                    float2 _Combine_989bd6296fa44c898dce3b24fde18c9d_RG_6;
                    Unity_Combine_float(_Split_ff0fd34a61f44fd7ae2f222441749bd9_R_1, _Split_ff0fd34a61f44fd7ae2f222441749bd9_G_2, _Split_ff0fd34a61f44fd7ae2f222441749bd9_B_3, 0, _Combine_989bd6296fa44c898dce3b24fde18c9d_RGBA_4, _Combine_989bd6296fa44c898dce3b24fde18c9d_RGB_5, _Combine_989bd6296fa44c898dce3b24fde18c9d_RG_6);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    #if defined(BOOLEAN_2D5E488208064DEDBE97E09FA59744E9_ON)
                    float3 _Waving_e9c7407f61464da88e74e85183ca2065_Out_0 = _Transform_5f6d055972de4e69871e05659dc0cf87_Out_1;
                    #else
                    float3 _Waving_e9c7407f61464da88e74e85183ca2065_Out_0 = _Combine_989bd6296fa44c898dce3b24fde18c9d_RGB_5;
                    #endif
                    #endif
                    description.Position = _Waving_e9c7407f61464da88e74e85183ca2065_Out_0;
                    description.Normal = IN.ObjectSpaceNormal;
                    description.Tangent = IN.ObjectSpaceTangent;
                    return description;
                }
    
                // Graph Pixel
                struct SurfaceDescription
                {
                    float3 BaseColor;
                    float3 NormalTS;
                    float3 Emission;
                    float Metallic;
                    float Smoothness;
                    float Occlusion;
                    float Alpha;
                    float AlphaClipThreshold;
                };
                
                SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                {
                    SurfaceDescription surface = (SurfaceDescription)0;
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Property_cd262e3649c94d36ac1a6035934c82ba_Out_0 = _shallowWaterColor;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Property_c08d4525fbf641d78eb168f9e6c77374_Out_0 = _deepWaterColor;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _SceneDepth_ff2814420f634b6c9006b17db1b0db86_Out_1;
                    Unity_SceneDepth_Linear01_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_ff2814420f634b6c9006b17db1b0db86_Out_1);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Multiply_7fe029570de94c259af598c01f1e9fc7_Out_2;
                    Unity_Multiply_float(_SceneDepth_ff2814420f634b6c9006b17db1b0db86_Out_1, _ProjectionParams.z, _Multiply_7fe029570de94c259af598c01f1e9fc7_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_69b3cbbc42e345ba9fcd9de510b5e2d7_Out_0 = _depth;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0 = IN.ScreenPosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Split_4da6c10dd6e44537a1e2021901925b9e_R_1 = _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0[0];
                    float _Split_4da6c10dd6e44537a1e2021901925b9e_G_2 = _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0[1];
                    float _Split_4da6c10dd6e44537a1e2021901925b9e_B_3 = _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0[2];
                    float _Split_4da6c10dd6e44537a1e2021901925b9e_A_4 = _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0[3];
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Add_5516261d5322477cbf6c851a3128394f_Out_2;
                    Unity_Add_float(_Property_69b3cbbc42e345ba9fcd9de510b5e2d7_Out_0, _Split_4da6c10dd6e44537a1e2021901925b9e_A_4, _Add_5516261d5322477cbf6c851a3128394f_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Subtract_f153dba44eeb4c808ffd45ea4a4f742e_Out_2;
                    Unity_Subtract_float(_Multiply_7fe029570de94c259af598c01f1e9fc7_Out_2, _Add_5516261d5322477cbf6c851a3128394f_Out_2, _Subtract_f153dba44eeb4c808ffd45ea4a4f742e_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_3b327dff25184e83be825e3db1854a26_Out_0 = _depthStrength;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Multiply_bcf5cd29cecf4b4f97083346027d340a_Out_2;
                    Unity_Multiply_float(_Subtract_f153dba44eeb4c808ffd45ea4a4f742e_Out_2, _Property_3b327dff25184e83be825e3db1854a26_Out_0, _Multiply_bcf5cd29cecf4b4f97083346027d340a_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Clamp_07516fbacac148a2ab07ae8f0615108e_Out_3;
                    Unity_Clamp_float(_Multiply_bcf5cd29cecf4b4f97083346027d340a_Out_2, 0, 1, _Clamp_07516fbacac148a2ab07ae8f0615108e_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3;
                    Unity_Lerp_float4(_Property_cd262e3649c94d36ac1a6035934c82ba_Out_0, _Property_c08d4525fbf641d78eb168f9e6c77374_Out_0, (_Clamp_07516fbacac148a2ab07ae8f0615108e_Out_3.xxxx), _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_5482a63064fe4dc986c10d26e2a866c9_Out_0 = _normalTiling;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Property_b18edaa63f6640f1abc5e1c084fa03d7_Out_0 = _mainNormalDirection;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_26a9c6abd5cb40b5bea80cc2e337259f_Out_2;
                    Unity_Multiply_float((IN.TimeParameters.x.xxx), _Property_b18edaa63f6640f1abc5e1c084fa03d7_Out_0, _Multiply_26a9c6abd5cb40b5bea80cc2e337259f_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Vector1_cce353cff4d443cbad9f0028192af8a7_Out_0 = 5;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Divide_436ce3df6a4b4ab384b5f9e6fde7cbff_Out_2;
                    Unity_Divide_float3(_Multiply_26a9c6abd5cb40b5bea80cc2e337259f_Out_2, (_Vector1_cce353cff4d443cbad9f0028192af8a7_Out_0.xxx), _Divide_436ce3df6a4b4ab384b5f9e6fde7cbff_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_a100da2d1db545d3bdd6a98d6c3338b4_Out_0 = _normalSpeed;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_52a0ffd9cfff4dbca39fd96e162d6f38_Out_2;
                    Unity_Multiply_float(_Divide_436ce3df6a4b4ab384b5f9e6fde7cbff_Out_2, (_Property_a100da2d1db545d3bdd6a98d6c3338b4_Out_0.xxx), _Multiply_52a0ffd9cfff4dbca39fd96e162d6f38_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float2 _TilingAndOffset_d7789ee50db3482f9d54ada635414804_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, (_Property_5482a63064fe4dc986c10d26e2a866c9_Out_0.xx), (_Multiply_52a0ffd9cfff4dbca39fd96e162d6f38_Out_2.xy), _TilingAndOffset_d7789ee50db3482f9d54ada635414804_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_RGBA_0 = SAMPLE_TEXTURE2D(_mainNormal, sampler_mainNormal, _TilingAndOffset_d7789ee50db3482f9d54ada635414804_Out_3);
                    _SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_RGBA_0);
                    float _SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_R_4 = _SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_RGBA_0.r;
                    float _SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_G_5 = _SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_RGBA_0.g;
                    float _SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_B_6 = _SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_RGBA_0.b;
                    float _SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_A_7 = _SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_RGBA_0.a;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Property_dbda2894373e42498a86446296d428f0_Out_0 = _secondNormalDirection;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_69c904868d6240009395971af991ea70_Out_2;
                    Unity_Multiply_float((IN.TimeParameters.x.xxx), _Property_dbda2894373e42498a86446296d428f0_Out_0, _Multiply_69c904868d6240009395971af991ea70_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Vector1_86da2039a4f840cba31ad8417eedfdbe_Out_0 = 5;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Divide_7e931fd752a14839ac903c8c1f23fa8b_Out_2;
                    Unity_Divide_float3(_Multiply_69c904868d6240009395971af991ea70_Out_2, (_Vector1_86da2039a4f840cba31ad8417eedfdbe_Out_0.xxx), _Divide_7e931fd752a14839ac903c8c1f23fa8b_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_9b564bc582834a84b02772947489b2ee_Out_0 = _normalSpeed;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_a0a0b6832fcd46c0badaac4e7758d9af_Out_2;
                    Unity_Multiply_float(_Divide_7e931fd752a14839ac903c8c1f23fa8b_Out_2, (_Property_9b564bc582834a84b02772947489b2ee_Out_0.xxx), _Multiply_a0a0b6832fcd46c0badaac4e7758d9af_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float2 _TilingAndOffset_248c7474eeba4e7b9f1353cc429027df_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, (_Property_5482a63064fe4dc986c10d26e2a866c9_Out_0.xx), (_Multiply_a0a0b6832fcd46c0badaac4e7758d9af_Out_2.xy), _TilingAndOffset_248c7474eeba4e7b9f1353cc429027df_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _SampleTexture2D_19fa380f103d42a49d00ac60250e471c_RGBA_0 = SAMPLE_TEXTURE2D(_secondNormal, sampler_secondNormal, _TilingAndOffset_248c7474eeba4e7b9f1353cc429027df_Out_3);
                    _SampleTexture2D_19fa380f103d42a49d00ac60250e471c_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_19fa380f103d42a49d00ac60250e471c_RGBA_0);
                    float _SampleTexture2D_19fa380f103d42a49d00ac60250e471c_R_4 = _SampleTexture2D_19fa380f103d42a49d00ac60250e471c_RGBA_0.r;
                    float _SampleTexture2D_19fa380f103d42a49d00ac60250e471c_G_5 = _SampleTexture2D_19fa380f103d42a49d00ac60250e471c_RGBA_0.g;
                    float _SampleTexture2D_19fa380f103d42a49d00ac60250e471c_B_6 = _SampleTexture2D_19fa380f103d42a49d00ac60250e471c_RGBA_0.b;
                    float _SampleTexture2D_19fa380f103d42a49d00ac60250e471c_A_7 = _SampleTexture2D_19fa380f103d42a49d00ac60250e471c_RGBA_0.a;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Add_848875f285c84daf9d7cce6829511404_Out_2;
                    Unity_Add_float4(_SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_RGBA_0, _SampleTexture2D_19fa380f103d42a49d00ac60250e471c_RGBA_0, _Add_848875f285c84daf9d7cce6829511404_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_8a702d79c0774b35aa6e24f8f95f098e_Out_0 = _normalStrength;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _NormalStrength_51ceaf799ace4a3abbc7030d015375d7_Out_2;
                    Unity_NormalStrength_float((_Add_848875f285c84daf9d7cce6829511404_Out_2.xyz), _Property_8a702d79c0774b35aa6e24f8f95f098e_Out_0, _NormalStrength_51ceaf799ace4a3abbc7030d015375d7_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_9dbd6cc5b1314dceb76f85fbbb09dc7d_Out_0 = _smoothness;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Split_5dc8f38583ee40c19b6f09138a95e012_R_1 = _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3[0];
                    float _Split_5dc8f38583ee40c19b6f09138a95e012_G_2 = _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3[1];
                    float _Split_5dc8f38583ee40c19b6f09138a95e012_B_3 = _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3[2];
                    float _Split_5dc8f38583ee40c19b6f09138a95e012_A_4 = _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3[3];
                    #endif
                    surface.BaseColor = (_Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3.xyz);
                    surface.NormalTS = _NormalStrength_51ceaf799ace4a3abbc7030d015375d7_Out_2;
                    surface.Emission = float3(0, 0, 0);
                    surface.Metallic = 0;
                    surface.Smoothness = _Property_9dbd6cc5b1314dceb76f85fbbb09dc7d_Out_0;
                    surface.Occlusion = 1;
                    surface.Alpha = _Split_5dc8f38583ee40c19b6f09138a95e012_A_4;
                    surface.AlphaClipThreshold = 0;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ObjectSpaceNormal =           input.normalOS;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ObjectSpaceTangent =          input.tangentOS;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ObjectSpacePosition =         input.positionOS;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpacePosition =          TransformObjectToWorld(input.positionOS);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.uv0 =                         input.uv0;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.TimeParameters =              _TimeParameters.xyz;
                #endif
                
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                #endif
                
                
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpacePosition =          input.positionWS;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.uv0 =                         input.texCoord0;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.TimeParameters =              _TimeParameters.xyz; // This is mainly for LW as HD overwrite this value
                #endif
                
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
                #else
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                #endif
                #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                
                    return output;
                }
                
    
                // --------------------------------------------------
                // Main
    
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/UnityGBuffer.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBRGBufferPass.hlsl"
    
                ENDHLSL
            }
            Pass
            {
                Name "ShadowCaster"
                Tags
                {
                    "LightMode" = "ShadowCaster"
                }
    
                // Render State
                Cull Back
                Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
                ZTest LEqual
                ZWrite On
    
                // Debug
                // <None>
    
                // --------------------------------------------------
                // Pass
    
                HLSLPROGRAM
    
                // Pragmas
                #pragma target 2.0
                #pragma only_renderers gles gles3
                #pragma multi_compile_instancing
                #pragma prefer_hlslcc gles
                #pragma vertex vert
                #pragma fragment frag
    
                // DotsInstancingOptions: <None>
                // HybridV1InjectedBuiltinProperties: <None>
    
                // Keywords
                // PassKeywords: <None>
                #pragma shader_feature_local _ BOOLEAN_2D5E488208064DEDBE97E09FA59744E9_ON
                
                #if defined(BOOLEAN_2D5E488208064DEDBE97E09FA59744E9_ON)
                    #define KEYWORD_PERMUTATION_0
                #else
                    #define KEYWORD_PERMUTATION_1
                #endif
                
    
                // Defines
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define _SURFACE_TYPE_TRANSPARENT 1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define _AlphaClip 1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define _NORMALMAP 1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define _NORMAL_DROPOFF_TS 1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define ATTRIBUTES_NEED_NORMAL
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define ATTRIBUTES_NEED_TANGENT
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define ATTRIBUTES_NEED_TEXCOORD0
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define VARYINGS_NEED_POSITION_WS
            #endif
    
                #define FEATURES_GRAPH_VERTEX
                /* WARNING: $splice Could not find named fragment 'PassInstancing' */
                #define SHADERPASS SHADERPASS_SHADOWCASTER
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #define REQUIRE_DEPTH_TEXTURE
                #endif
                /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
    
                // Includes
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
    
                // --------------------------------------------------
                // Structs and Packing
    
                struct Attributes
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 positionOS : POSITION;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 normalOS : NORMAL;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 tangentOS : TANGENT;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 uv0 : TEXCOORD0;
                    #endif
                    #if UNITY_ANY_INSTANCING_ENABLED
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint instanceID : INSTANCEID_SEMANTIC;
                    #endif
                    #endif
                };
                struct Varyings
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 positionCS : SV_POSITION;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 positionWS;
                    #endif
                    #if UNITY_ANY_INSTANCING_ENABLED
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                    #endif
                };
                struct SurfaceDescriptionInputs
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpacePosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 ScreenPosition;
                    #endif
                };
                struct VertexDescriptionInputs
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 ObjectSpaceNormal;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpaceNormal;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 ObjectSpaceTangent;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpaceTangent;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 ObjectSpaceBiTangent;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpaceBiTangent;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 ObjectSpacePosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpacePosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 uv0;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 TimeParameters;
                    #endif
                };
                struct PackedVaryings
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 positionCS : SV_POSITION;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 interp0 : TEXCOORD0;
                    #endif
                    #if UNITY_ANY_INSTANCING_ENABLED
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                    #endif
                };
    
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                PackedVaryings PackVaryings (Varyings input)
                    {
                        PackedVaryings output;
                        output.positionCS = input.positionCS;
                        output.interp0.xyz =  input.positionWS;
                        #if UNITY_ANY_INSTANCING_ENABLED
                        output.instanceID = input.instanceID;
                        #endif
                        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                        #endif
                        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                        #endif
                        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                        output.cullFace = input.cullFace;
                        #endif
                        return output;
                    }
                    Varyings UnpackVaryings (PackedVaryings input)
                    {
                        Varyings output;
                        output.positionCS = input.positionCS;
                        output.positionWS = input.interp0.xyz;
                        #if UNITY_ANY_INSTANCING_ENABLED
                        output.instanceID = input.instanceID;
                        #endif
                        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                        #endif
                        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                        #endif
                        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                        output.cullFace = input.cullFace;
                        #endif
                        return output;
                    }
                #endif
    
                // --------------------------------------------------
                // Graph
    
                // Graph Properties
                CBUFFER_START(UnityPerMaterial)
                float _depth;
                float _depthStrength;
                float4 _deepWaterColor;
                float4 _shallowWaterColor;
                float _smoothness;
                float _normalStrength;
                float _normalTiling;
                float _normalSpeed;
                float3 _mainNormalDirection;
                float3 _secondNormalDirection;
                float _amplitude;
                float _waves;
                float _wavesSpeed;
                CBUFFER_END
                TEXTURE2D(_mainNormal); SAMPLER(sampler_mainNormal); float4 _mainNormal_TexelSize;
                TEXTURE2D(_secondNormal); SAMPLER(sampler_secondNormal); float4 _secondNormal_TexelSize;
    
                // Graph Functions
                
                void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A / B;
                }
                
                void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                {
                    Out = UV * Tiling + Offset;
                }
                
                
                float2 Unity_GradientNoise_Dir_float(float2 p)
                {
                    // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
                    p = p % 289;
                    // need full precision, otherwise half overflows when p > 1
                    float x = float(34 * p.x + 1) * p.x % 289 + p.y;
                    x = (34 * x + 1) * x % 289;
                    x = frac(x / 41) * 2 - 1;
                    return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
                }
                
                void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
                { 
                    float2 p = UV * Scale;
                    float2 ip = floor(p);
                    float2 fp = frac(p);
                    float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
                    float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
                    float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
                    float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
                    fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
                    Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
                }
                
                void Unity_Add_float(float A, float B, out float Out)
                {
                    Out = A + B;
                }
                
                void Unity_Divide_float(float A, float B, out float Out)
                {
                    Out = A / B;
                }
                
                void Unity_Subtract_float(float A, float B, out float Out)
                {
                    Out = A - B;
                }
                
                void Unity_Multiply_float(float A, float B, out float Out)
                {
                    Out = A * B;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_SceneDepth_Linear01_float(float4 UV, out float Out)
                {
                    Out = Linear01Depth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
                }
                
                void Unity_Clamp_float(float In, float Min, float Max, out float Out)
                {
                    Out = clamp(In, Min, Max);
                }
                
                void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
                {
                    Out = lerp(A, B, T);
                }
    
                // Graph Vertex
                struct VertexDescription
                {
                    float3 Position;
                    float3 Normal;
                    float3 Tangent;
                };
                
                VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                {
                    VertexDescription description = (VertexDescription)0;
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Split_ff0fd34a61f44fd7ae2f222441749bd9_R_1 = IN.WorldSpacePosition[0];
                    float _Split_ff0fd34a61f44fd7ae2f222441749bd9_G_2 = IN.WorldSpacePosition[1];
                    float _Split_ff0fd34a61f44fd7ae2f222441749bd9_B_3 = IN.WorldSpacePosition[2];
                    float _Split_ff0fd34a61f44fd7ae2f222441749bd9_A_4 = 0;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_f4af681ed89a4a3d8c81333e9f8b562d_Out_0 = _waves;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Property_49ef859bb89c4a8288c9eb1583334fde_Out_0 = _mainNormalDirection;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_992df1e5e71b4479bbb5a25e534d8861_Out_2;
                    Unity_Multiply_float((IN.TimeParameters.x.xxx), _Property_49ef859bb89c4a8288c9eb1583334fde_Out_0, _Multiply_992df1e5e71b4479bbb5a25e534d8861_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Vector1_60e9a38039a843989ca21ba08ba76bd7_Out_0 = 5;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Divide_eb274efe27a64e71ba9baa084548bb6c_Out_2;
                    Unity_Divide_float3(_Multiply_992df1e5e71b4479bbb5a25e534d8861_Out_2, (_Vector1_60e9a38039a843989ca21ba08ba76bd7_Out_0.xxx), _Divide_eb274efe27a64e71ba9baa084548bb6c_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_92f37cd5909d40809e2b672d1636bd54_Out_0 = _wavesSpeed;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_afb804d1277148d7b992f652bb14e3be_Out_2;
                    Unity_Multiply_float(_Divide_eb274efe27a64e71ba9baa084548bb6c_Out_2, (_Property_92f37cd5909d40809e2b672d1636bd54_Out_0.xxx), _Multiply_afb804d1277148d7b992f652bb14e3be_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float2 _TilingAndOffset_05baded2421248cd9222b83233309dcb_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, (_Property_f4af681ed89a4a3d8c81333e9f8b562d_Out_0.xx), (_Multiply_afb804d1277148d7b992f652bb14e3be_Out_2.xy), _TilingAndOffset_05baded2421248cd9222b83233309dcb_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _GradientNoise_5b5f40a249b347c9be3b4afc6d0ed3ad_Out_2;
                    Unity_GradientNoise_float(_TilingAndOffset_05baded2421248cd9222b83233309dcb_Out_3, 10, _GradientNoise_5b5f40a249b347c9be3b4afc6d0ed3ad_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Property_666f9a531b564538acc376057bc6caa9_Out_0 = _secondNormalDirection;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_118898149cbd4850b0807b9467ed73b4_Out_2;
                    Unity_Multiply_float((IN.TimeParameters.x.xxx), _Property_666f9a531b564538acc376057bc6caa9_Out_0, _Multiply_118898149cbd4850b0807b9467ed73b4_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Vector1_ea96af95fe4f4961ad8bfc89f5bc9a03_Out_0 = 5;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Divide_b7c139d64ea9401fbda3a903c9fd1bf6_Out_2;
                    Unity_Divide_float3(_Multiply_118898149cbd4850b0807b9467ed73b4_Out_2, (_Vector1_ea96af95fe4f4961ad8bfc89f5bc9a03_Out_0.xxx), _Divide_b7c139d64ea9401fbda3a903c9fd1bf6_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_6199970682ac4c9c947732b8aa1e32b0_Out_2;
                    Unity_Multiply_float(_Divide_b7c139d64ea9401fbda3a903c9fd1bf6_Out_2, (_Property_92f37cd5909d40809e2b672d1636bd54_Out_0.xxx), _Multiply_6199970682ac4c9c947732b8aa1e32b0_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float2 _TilingAndOffset_2d869c568f8c4bd1935e9e1a5d383ff4_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, (_Property_f4af681ed89a4a3d8c81333e9f8b562d_Out_0.xx), (_Multiply_6199970682ac4c9c947732b8aa1e32b0_Out_2.xy), _TilingAndOffset_2d869c568f8c4bd1935e9e1a5d383ff4_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _GradientNoise_7d50ab18cca7435cbe45ace0410a84c7_Out_2;
                    Unity_GradientNoise_float(_TilingAndOffset_2d869c568f8c4bd1935e9e1a5d383ff4_Out_3, 10, _GradientNoise_7d50ab18cca7435cbe45ace0410a84c7_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Add_3ab7d42c644a4df381d663f07b7ab1e9_Out_2;
                    Unity_Add_float(_GradientNoise_5b5f40a249b347c9be3b4afc6d0ed3ad_Out_2, _GradientNoise_7d50ab18cca7435cbe45ace0410a84c7_Out_2, _Add_3ab7d42c644a4df381d663f07b7ab1e9_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Divide_cefb6bacdd4e476ea8103edefe43f584_Out_2;
                    Unity_Divide_float(_Add_3ab7d42c644a4df381d663f07b7ab1e9_Out_2, 2, _Divide_cefb6bacdd4e476ea8103edefe43f584_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Subtract_4da7b6862bcc45eca57cbd26b806eaf0_Out_2;
                    Unity_Subtract_float(_Divide_cefb6bacdd4e476ea8103edefe43f584_Out_2, 0.61, _Subtract_4da7b6862bcc45eca57cbd26b806eaf0_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_ce933f1cb0934b47a86069374aea82d8_Out_0 = _amplitude;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Multiply_fc80491e653843f7b95b7d963584d21d_Out_2;
                    Unity_Multiply_float(_Subtract_4da7b6862bcc45eca57cbd26b806eaf0_Out_2, _Property_ce933f1cb0934b47a86069374aea82d8_Out_0, _Multiply_fc80491e653843f7b95b7d963584d21d_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Combine_4394e5327dea4ebda9c6b40c020e0721_RGBA_4;
                    float3 _Combine_4394e5327dea4ebda9c6b40c020e0721_RGB_5;
                    float2 _Combine_4394e5327dea4ebda9c6b40c020e0721_RG_6;
                    Unity_Combine_float(_Split_ff0fd34a61f44fd7ae2f222441749bd9_R_1, _Multiply_fc80491e653843f7b95b7d963584d21d_Out_2, _Split_ff0fd34a61f44fd7ae2f222441749bd9_B_3, 0, _Combine_4394e5327dea4ebda9c6b40c020e0721_RGBA_4, _Combine_4394e5327dea4ebda9c6b40c020e0721_RGB_5, _Combine_4394e5327dea4ebda9c6b40c020e0721_RG_6);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Transform_5f6d055972de4e69871e05659dc0cf87_Out_1 = TransformWorldToObject(_Combine_4394e5327dea4ebda9c6b40c020e0721_RGB_5.xyz);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Combine_989bd6296fa44c898dce3b24fde18c9d_RGBA_4;
                    float3 _Combine_989bd6296fa44c898dce3b24fde18c9d_RGB_5;
                    float2 _Combine_989bd6296fa44c898dce3b24fde18c9d_RG_6;
                    Unity_Combine_float(_Split_ff0fd34a61f44fd7ae2f222441749bd9_R_1, _Split_ff0fd34a61f44fd7ae2f222441749bd9_G_2, _Split_ff0fd34a61f44fd7ae2f222441749bd9_B_3, 0, _Combine_989bd6296fa44c898dce3b24fde18c9d_RGBA_4, _Combine_989bd6296fa44c898dce3b24fde18c9d_RGB_5, _Combine_989bd6296fa44c898dce3b24fde18c9d_RG_6);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    #if defined(BOOLEAN_2D5E488208064DEDBE97E09FA59744E9_ON)
                    float3 _Waving_e9c7407f61464da88e74e85183ca2065_Out_0 = _Transform_5f6d055972de4e69871e05659dc0cf87_Out_1;
                    #else
                    float3 _Waving_e9c7407f61464da88e74e85183ca2065_Out_0 = _Combine_989bd6296fa44c898dce3b24fde18c9d_RGB_5;
                    #endif
                    #endif
                    description.Position = _Waving_e9c7407f61464da88e74e85183ca2065_Out_0;
                    description.Normal = IN.ObjectSpaceNormal;
                    description.Tangent = IN.ObjectSpaceTangent;
                    return description;
                }
    
                // Graph Pixel
                struct SurfaceDescription
                {
                    float Alpha;
                    float AlphaClipThreshold;
                };
                
                SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                {
                    SurfaceDescription surface = (SurfaceDescription)0;
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Property_cd262e3649c94d36ac1a6035934c82ba_Out_0 = _shallowWaterColor;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Property_c08d4525fbf641d78eb168f9e6c77374_Out_0 = _deepWaterColor;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _SceneDepth_ff2814420f634b6c9006b17db1b0db86_Out_1;
                    Unity_SceneDepth_Linear01_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_ff2814420f634b6c9006b17db1b0db86_Out_1);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Multiply_7fe029570de94c259af598c01f1e9fc7_Out_2;
                    Unity_Multiply_float(_SceneDepth_ff2814420f634b6c9006b17db1b0db86_Out_1, _ProjectionParams.z, _Multiply_7fe029570de94c259af598c01f1e9fc7_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_69b3cbbc42e345ba9fcd9de510b5e2d7_Out_0 = _depth;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0 = IN.ScreenPosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Split_4da6c10dd6e44537a1e2021901925b9e_R_1 = _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0[0];
                    float _Split_4da6c10dd6e44537a1e2021901925b9e_G_2 = _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0[1];
                    float _Split_4da6c10dd6e44537a1e2021901925b9e_B_3 = _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0[2];
                    float _Split_4da6c10dd6e44537a1e2021901925b9e_A_4 = _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0[3];
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Add_5516261d5322477cbf6c851a3128394f_Out_2;
                    Unity_Add_float(_Property_69b3cbbc42e345ba9fcd9de510b5e2d7_Out_0, _Split_4da6c10dd6e44537a1e2021901925b9e_A_4, _Add_5516261d5322477cbf6c851a3128394f_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Subtract_f153dba44eeb4c808ffd45ea4a4f742e_Out_2;
                    Unity_Subtract_float(_Multiply_7fe029570de94c259af598c01f1e9fc7_Out_2, _Add_5516261d5322477cbf6c851a3128394f_Out_2, _Subtract_f153dba44eeb4c808ffd45ea4a4f742e_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_3b327dff25184e83be825e3db1854a26_Out_0 = _depthStrength;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Multiply_bcf5cd29cecf4b4f97083346027d340a_Out_2;
                    Unity_Multiply_float(_Subtract_f153dba44eeb4c808ffd45ea4a4f742e_Out_2, _Property_3b327dff25184e83be825e3db1854a26_Out_0, _Multiply_bcf5cd29cecf4b4f97083346027d340a_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Clamp_07516fbacac148a2ab07ae8f0615108e_Out_3;
                    Unity_Clamp_float(_Multiply_bcf5cd29cecf4b4f97083346027d340a_Out_2, 0, 1, _Clamp_07516fbacac148a2ab07ae8f0615108e_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3;
                    Unity_Lerp_float4(_Property_cd262e3649c94d36ac1a6035934c82ba_Out_0, _Property_c08d4525fbf641d78eb168f9e6c77374_Out_0, (_Clamp_07516fbacac148a2ab07ae8f0615108e_Out_3.xxxx), _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Split_5dc8f38583ee40c19b6f09138a95e012_R_1 = _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3[0];
                    float _Split_5dc8f38583ee40c19b6f09138a95e012_G_2 = _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3[1];
                    float _Split_5dc8f38583ee40c19b6f09138a95e012_B_3 = _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3[2];
                    float _Split_5dc8f38583ee40c19b6f09138a95e012_A_4 = _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3[3];
                    #endif
                    surface.Alpha = _Split_5dc8f38583ee40c19b6f09138a95e012_A_4;
                    surface.AlphaClipThreshold = 0;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ObjectSpaceNormal =           input.normalOS;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ObjectSpaceTangent =          input.tangentOS;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ObjectSpacePosition =         input.positionOS;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpacePosition =          TransformObjectToWorld(input.positionOS);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.uv0 =                         input.uv0;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.TimeParameters =              _TimeParameters.xyz;
                #endif
                
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                
                
                
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpacePosition =          input.positionWS;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
                #endif
                
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
                #else
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                #endif
                #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                
                    return output;
                }
                
    
                // --------------------------------------------------
                // Main
    
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShadowCasterPass.hlsl"
    
                ENDHLSL
            }
            Pass
            {
                Name "DepthOnly"
                Tags
                {
                    "LightMode" = "DepthOnly"
                }
    
                // Render State
                Cull Back
                Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
                ZTest LEqual
                ZWrite On
                ColorMask 0
    
                // Debug
                // <None>
    
                // --------------------------------------------------
                // Pass
    
                HLSLPROGRAM
    
                // Pragmas
                #pragma target 2.0
                #pragma only_renderers gles gles3
                #pragma multi_compile_instancing
                #pragma prefer_hlslcc gles
                #pragma vertex vert
                #pragma fragment frag
    
                // DotsInstancingOptions: <None>
                // HybridV1InjectedBuiltinProperties: <None>
    
                // Keywords
                // PassKeywords: <None>
                #pragma shader_feature_local _ BOOLEAN_2D5E488208064DEDBE97E09FA59744E9_ON
                
                #if defined(BOOLEAN_2D5E488208064DEDBE97E09FA59744E9_ON)
                    #define KEYWORD_PERMUTATION_0
                #else
                    #define KEYWORD_PERMUTATION_1
                #endif
                
    
                // Defines
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define _SURFACE_TYPE_TRANSPARENT 1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define _AlphaClip 1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define _NORMALMAP 1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define _NORMAL_DROPOFF_TS 1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define ATTRIBUTES_NEED_NORMAL
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define ATTRIBUTES_NEED_TANGENT
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define ATTRIBUTES_NEED_TEXCOORD0
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define VARYINGS_NEED_POSITION_WS
            #endif
    
                #define FEATURES_GRAPH_VERTEX
                /* WARNING: $splice Could not find named fragment 'PassInstancing' */
                #define SHADERPASS SHADERPASS_DEPTHONLY
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #define REQUIRE_DEPTH_TEXTURE
                #endif
                /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
    
                // Includes
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
    
                // --------------------------------------------------
                // Structs and Packing
    
                struct Attributes
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 positionOS : POSITION;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 normalOS : NORMAL;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 tangentOS : TANGENT;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 uv0 : TEXCOORD0;
                    #endif
                    #if UNITY_ANY_INSTANCING_ENABLED
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint instanceID : INSTANCEID_SEMANTIC;
                    #endif
                    #endif
                };
                struct Varyings
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 positionCS : SV_POSITION;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 positionWS;
                    #endif
                    #if UNITY_ANY_INSTANCING_ENABLED
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                    #endif
                };
                struct SurfaceDescriptionInputs
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpacePosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 ScreenPosition;
                    #endif
                };
                struct VertexDescriptionInputs
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 ObjectSpaceNormal;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpaceNormal;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 ObjectSpaceTangent;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpaceTangent;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 ObjectSpaceBiTangent;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpaceBiTangent;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 ObjectSpacePosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpacePosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 uv0;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 TimeParameters;
                    #endif
                };
                struct PackedVaryings
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 positionCS : SV_POSITION;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 interp0 : TEXCOORD0;
                    #endif
                    #if UNITY_ANY_INSTANCING_ENABLED
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                    #endif
                };
    
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                PackedVaryings PackVaryings (Varyings input)
                    {
                        PackedVaryings output;
                        output.positionCS = input.positionCS;
                        output.interp0.xyz =  input.positionWS;
                        #if UNITY_ANY_INSTANCING_ENABLED
                        output.instanceID = input.instanceID;
                        #endif
                        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                        #endif
                        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                        #endif
                        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                        output.cullFace = input.cullFace;
                        #endif
                        return output;
                    }
                    Varyings UnpackVaryings (PackedVaryings input)
                    {
                        Varyings output;
                        output.positionCS = input.positionCS;
                        output.positionWS = input.interp0.xyz;
                        #if UNITY_ANY_INSTANCING_ENABLED
                        output.instanceID = input.instanceID;
                        #endif
                        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                        #endif
                        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                        #endif
                        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                        output.cullFace = input.cullFace;
                        #endif
                        return output;
                    }
                #endif
    
                // --------------------------------------------------
                // Graph
    
                // Graph Properties
                CBUFFER_START(UnityPerMaterial)
                float _depth;
                float _depthStrength;
                float4 _deepWaterColor;
                float4 _shallowWaterColor;
                float _smoothness;
                float _normalStrength;
                float _normalTiling;
                float _normalSpeed;
                float3 _mainNormalDirection;
                float3 _secondNormalDirection;
                float _amplitude;
                float _waves;
                float _wavesSpeed;
                CBUFFER_END
                TEXTURE2D(_mainNormal); SAMPLER(sampler_mainNormal); float4 _mainNormal_TexelSize;
                TEXTURE2D(_secondNormal); SAMPLER(sampler_secondNormal); float4 _secondNormal_TexelSize;
    
                // Graph Functions
                
                void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A / B;
                }
                
                void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                {
                    Out = UV * Tiling + Offset;
                }
                
                
                float2 Unity_GradientNoise_Dir_float(float2 p)
                {
                    // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
                    p = p % 289;
                    // need full precision, otherwise half overflows when p > 1
                    float x = float(34 * p.x + 1) * p.x % 289 + p.y;
                    x = (34 * x + 1) * x % 289;
                    x = frac(x / 41) * 2 - 1;
                    return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
                }
                
                void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
                { 
                    float2 p = UV * Scale;
                    float2 ip = floor(p);
                    float2 fp = frac(p);
                    float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
                    float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
                    float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
                    float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
                    fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
                    Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
                }
                
                void Unity_Add_float(float A, float B, out float Out)
                {
                    Out = A + B;
                }
                
                void Unity_Divide_float(float A, float B, out float Out)
                {
                    Out = A / B;
                }
                
                void Unity_Subtract_float(float A, float B, out float Out)
                {
                    Out = A - B;
                }
                
                void Unity_Multiply_float(float A, float B, out float Out)
                {
                    Out = A * B;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_SceneDepth_Linear01_float(float4 UV, out float Out)
                {
                    Out = Linear01Depth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
                }
                
                void Unity_Clamp_float(float In, float Min, float Max, out float Out)
                {
                    Out = clamp(In, Min, Max);
                }
                
                void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
                {
                    Out = lerp(A, B, T);
                }
    
                // Graph Vertex
                struct VertexDescription
                {
                    float3 Position;
                    float3 Normal;
                    float3 Tangent;
                };
                
                VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                {
                    VertexDescription description = (VertexDescription)0;
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Split_ff0fd34a61f44fd7ae2f222441749bd9_R_1 = IN.WorldSpacePosition[0];
                    float _Split_ff0fd34a61f44fd7ae2f222441749bd9_G_2 = IN.WorldSpacePosition[1];
                    float _Split_ff0fd34a61f44fd7ae2f222441749bd9_B_3 = IN.WorldSpacePosition[2];
                    float _Split_ff0fd34a61f44fd7ae2f222441749bd9_A_4 = 0;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_f4af681ed89a4a3d8c81333e9f8b562d_Out_0 = _waves;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Property_49ef859bb89c4a8288c9eb1583334fde_Out_0 = _mainNormalDirection;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_992df1e5e71b4479bbb5a25e534d8861_Out_2;
                    Unity_Multiply_float((IN.TimeParameters.x.xxx), _Property_49ef859bb89c4a8288c9eb1583334fde_Out_0, _Multiply_992df1e5e71b4479bbb5a25e534d8861_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Vector1_60e9a38039a843989ca21ba08ba76bd7_Out_0 = 5;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Divide_eb274efe27a64e71ba9baa084548bb6c_Out_2;
                    Unity_Divide_float3(_Multiply_992df1e5e71b4479bbb5a25e534d8861_Out_2, (_Vector1_60e9a38039a843989ca21ba08ba76bd7_Out_0.xxx), _Divide_eb274efe27a64e71ba9baa084548bb6c_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_92f37cd5909d40809e2b672d1636bd54_Out_0 = _wavesSpeed;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_afb804d1277148d7b992f652bb14e3be_Out_2;
                    Unity_Multiply_float(_Divide_eb274efe27a64e71ba9baa084548bb6c_Out_2, (_Property_92f37cd5909d40809e2b672d1636bd54_Out_0.xxx), _Multiply_afb804d1277148d7b992f652bb14e3be_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float2 _TilingAndOffset_05baded2421248cd9222b83233309dcb_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, (_Property_f4af681ed89a4a3d8c81333e9f8b562d_Out_0.xx), (_Multiply_afb804d1277148d7b992f652bb14e3be_Out_2.xy), _TilingAndOffset_05baded2421248cd9222b83233309dcb_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _GradientNoise_5b5f40a249b347c9be3b4afc6d0ed3ad_Out_2;
                    Unity_GradientNoise_float(_TilingAndOffset_05baded2421248cd9222b83233309dcb_Out_3, 10, _GradientNoise_5b5f40a249b347c9be3b4afc6d0ed3ad_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Property_666f9a531b564538acc376057bc6caa9_Out_0 = _secondNormalDirection;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_118898149cbd4850b0807b9467ed73b4_Out_2;
                    Unity_Multiply_float((IN.TimeParameters.x.xxx), _Property_666f9a531b564538acc376057bc6caa9_Out_0, _Multiply_118898149cbd4850b0807b9467ed73b4_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Vector1_ea96af95fe4f4961ad8bfc89f5bc9a03_Out_0 = 5;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Divide_b7c139d64ea9401fbda3a903c9fd1bf6_Out_2;
                    Unity_Divide_float3(_Multiply_118898149cbd4850b0807b9467ed73b4_Out_2, (_Vector1_ea96af95fe4f4961ad8bfc89f5bc9a03_Out_0.xxx), _Divide_b7c139d64ea9401fbda3a903c9fd1bf6_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_6199970682ac4c9c947732b8aa1e32b0_Out_2;
                    Unity_Multiply_float(_Divide_b7c139d64ea9401fbda3a903c9fd1bf6_Out_2, (_Property_92f37cd5909d40809e2b672d1636bd54_Out_0.xxx), _Multiply_6199970682ac4c9c947732b8aa1e32b0_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float2 _TilingAndOffset_2d869c568f8c4bd1935e9e1a5d383ff4_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, (_Property_f4af681ed89a4a3d8c81333e9f8b562d_Out_0.xx), (_Multiply_6199970682ac4c9c947732b8aa1e32b0_Out_2.xy), _TilingAndOffset_2d869c568f8c4bd1935e9e1a5d383ff4_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _GradientNoise_7d50ab18cca7435cbe45ace0410a84c7_Out_2;
                    Unity_GradientNoise_float(_TilingAndOffset_2d869c568f8c4bd1935e9e1a5d383ff4_Out_3, 10, _GradientNoise_7d50ab18cca7435cbe45ace0410a84c7_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Add_3ab7d42c644a4df381d663f07b7ab1e9_Out_2;
                    Unity_Add_float(_GradientNoise_5b5f40a249b347c9be3b4afc6d0ed3ad_Out_2, _GradientNoise_7d50ab18cca7435cbe45ace0410a84c7_Out_2, _Add_3ab7d42c644a4df381d663f07b7ab1e9_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Divide_cefb6bacdd4e476ea8103edefe43f584_Out_2;
                    Unity_Divide_float(_Add_3ab7d42c644a4df381d663f07b7ab1e9_Out_2, 2, _Divide_cefb6bacdd4e476ea8103edefe43f584_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Subtract_4da7b6862bcc45eca57cbd26b806eaf0_Out_2;
                    Unity_Subtract_float(_Divide_cefb6bacdd4e476ea8103edefe43f584_Out_2, 0.61, _Subtract_4da7b6862bcc45eca57cbd26b806eaf0_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_ce933f1cb0934b47a86069374aea82d8_Out_0 = _amplitude;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Multiply_fc80491e653843f7b95b7d963584d21d_Out_2;
                    Unity_Multiply_float(_Subtract_4da7b6862bcc45eca57cbd26b806eaf0_Out_2, _Property_ce933f1cb0934b47a86069374aea82d8_Out_0, _Multiply_fc80491e653843f7b95b7d963584d21d_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Combine_4394e5327dea4ebda9c6b40c020e0721_RGBA_4;
                    float3 _Combine_4394e5327dea4ebda9c6b40c020e0721_RGB_5;
                    float2 _Combine_4394e5327dea4ebda9c6b40c020e0721_RG_6;
                    Unity_Combine_float(_Split_ff0fd34a61f44fd7ae2f222441749bd9_R_1, _Multiply_fc80491e653843f7b95b7d963584d21d_Out_2, _Split_ff0fd34a61f44fd7ae2f222441749bd9_B_3, 0, _Combine_4394e5327dea4ebda9c6b40c020e0721_RGBA_4, _Combine_4394e5327dea4ebda9c6b40c020e0721_RGB_5, _Combine_4394e5327dea4ebda9c6b40c020e0721_RG_6);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Transform_5f6d055972de4e69871e05659dc0cf87_Out_1 = TransformWorldToObject(_Combine_4394e5327dea4ebda9c6b40c020e0721_RGB_5.xyz);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Combine_989bd6296fa44c898dce3b24fde18c9d_RGBA_4;
                    float3 _Combine_989bd6296fa44c898dce3b24fde18c9d_RGB_5;
                    float2 _Combine_989bd6296fa44c898dce3b24fde18c9d_RG_6;
                    Unity_Combine_float(_Split_ff0fd34a61f44fd7ae2f222441749bd9_R_1, _Split_ff0fd34a61f44fd7ae2f222441749bd9_G_2, _Split_ff0fd34a61f44fd7ae2f222441749bd9_B_3, 0, _Combine_989bd6296fa44c898dce3b24fde18c9d_RGBA_4, _Combine_989bd6296fa44c898dce3b24fde18c9d_RGB_5, _Combine_989bd6296fa44c898dce3b24fde18c9d_RG_6);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    #if defined(BOOLEAN_2D5E488208064DEDBE97E09FA59744E9_ON)
                    float3 _Waving_e9c7407f61464da88e74e85183ca2065_Out_0 = _Transform_5f6d055972de4e69871e05659dc0cf87_Out_1;
                    #else
                    float3 _Waving_e9c7407f61464da88e74e85183ca2065_Out_0 = _Combine_989bd6296fa44c898dce3b24fde18c9d_RGB_5;
                    #endif
                    #endif
                    description.Position = _Waving_e9c7407f61464da88e74e85183ca2065_Out_0;
                    description.Normal = IN.ObjectSpaceNormal;
                    description.Tangent = IN.ObjectSpaceTangent;
                    return description;
                }
    
                // Graph Pixel
                struct SurfaceDescription
                {
                    float Alpha;
                    float AlphaClipThreshold;
                };
                
                SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                {
                    SurfaceDescription surface = (SurfaceDescription)0;
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Property_cd262e3649c94d36ac1a6035934c82ba_Out_0 = _shallowWaterColor;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Property_c08d4525fbf641d78eb168f9e6c77374_Out_0 = _deepWaterColor;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _SceneDepth_ff2814420f634b6c9006b17db1b0db86_Out_1;
                    Unity_SceneDepth_Linear01_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_ff2814420f634b6c9006b17db1b0db86_Out_1);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Multiply_7fe029570de94c259af598c01f1e9fc7_Out_2;
                    Unity_Multiply_float(_SceneDepth_ff2814420f634b6c9006b17db1b0db86_Out_1, _ProjectionParams.z, _Multiply_7fe029570de94c259af598c01f1e9fc7_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_69b3cbbc42e345ba9fcd9de510b5e2d7_Out_0 = _depth;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0 = IN.ScreenPosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Split_4da6c10dd6e44537a1e2021901925b9e_R_1 = _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0[0];
                    float _Split_4da6c10dd6e44537a1e2021901925b9e_G_2 = _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0[1];
                    float _Split_4da6c10dd6e44537a1e2021901925b9e_B_3 = _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0[2];
                    float _Split_4da6c10dd6e44537a1e2021901925b9e_A_4 = _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0[3];
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Add_5516261d5322477cbf6c851a3128394f_Out_2;
                    Unity_Add_float(_Property_69b3cbbc42e345ba9fcd9de510b5e2d7_Out_0, _Split_4da6c10dd6e44537a1e2021901925b9e_A_4, _Add_5516261d5322477cbf6c851a3128394f_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Subtract_f153dba44eeb4c808ffd45ea4a4f742e_Out_2;
                    Unity_Subtract_float(_Multiply_7fe029570de94c259af598c01f1e9fc7_Out_2, _Add_5516261d5322477cbf6c851a3128394f_Out_2, _Subtract_f153dba44eeb4c808ffd45ea4a4f742e_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_3b327dff25184e83be825e3db1854a26_Out_0 = _depthStrength;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Multiply_bcf5cd29cecf4b4f97083346027d340a_Out_2;
                    Unity_Multiply_float(_Subtract_f153dba44eeb4c808ffd45ea4a4f742e_Out_2, _Property_3b327dff25184e83be825e3db1854a26_Out_0, _Multiply_bcf5cd29cecf4b4f97083346027d340a_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Clamp_07516fbacac148a2ab07ae8f0615108e_Out_3;
                    Unity_Clamp_float(_Multiply_bcf5cd29cecf4b4f97083346027d340a_Out_2, 0, 1, _Clamp_07516fbacac148a2ab07ae8f0615108e_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3;
                    Unity_Lerp_float4(_Property_cd262e3649c94d36ac1a6035934c82ba_Out_0, _Property_c08d4525fbf641d78eb168f9e6c77374_Out_0, (_Clamp_07516fbacac148a2ab07ae8f0615108e_Out_3.xxxx), _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Split_5dc8f38583ee40c19b6f09138a95e012_R_1 = _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3[0];
                    float _Split_5dc8f38583ee40c19b6f09138a95e012_G_2 = _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3[1];
                    float _Split_5dc8f38583ee40c19b6f09138a95e012_B_3 = _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3[2];
                    float _Split_5dc8f38583ee40c19b6f09138a95e012_A_4 = _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3[3];
                    #endif
                    surface.Alpha = _Split_5dc8f38583ee40c19b6f09138a95e012_A_4;
                    surface.AlphaClipThreshold = 0;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ObjectSpaceNormal =           input.normalOS;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ObjectSpaceTangent =          input.tangentOS;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ObjectSpacePosition =         input.positionOS;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpacePosition =          TransformObjectToWorld(input.positionOS);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.uv0 =                         input.uv0;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.TimeParameters =              _TimeParameters.xyz;
                #endif
                
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                
                
                
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpacePosition =          input.positionWS;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
                #endif
                
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
                #else
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                #endif
                #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                
                    return output;
                }
                
    
                // --------------------------------------------------
                // Main
    
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthOnlyPass.hlsl"
    
                ENDHLSL
            }
            Pass
            {
                Name "Meta"
                Tags
                {
                    "LightMode" = "Meta"
                }
    
                // Render State
                Cull Back
                Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
                ZTest LEqual
                ZWrite On
    
                // Debug
                // <None>
    
                // --------------------------------------------------
                // Pass
    
                HLSLPROGRAM
    
                // Pragmas
                #pragma target 2.0
                #pragma only_renderers gles gles3
                #pragma prefer_hlslcc gles
                #pragma vertex vert
                #pragma fragment frag
    
                // DotsInstancingOptions: <None>
                // HybridV1InjectedBuiltinProperties: <None>
    
                // Keywords
                #pragma shader_feature _ _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A
                #pragma shader_feature_local _ BOOLEAN_2D5E488208064DEDBE97E09FA59744E9_ON
                
                #if defined(BOOLEAN_2D5E488208064DEDBE97E09FA59744E9_ON)
                    #define KEYWORD_PERMUTATION_0
                #else
                    #define KEYWORD_PERMUTATION_1
                #endif
                
    
                // Defines
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define _SURFACE_TYPE_TRANSPARENT 1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define _AlphaClip 1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define _NORMALMAP 1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define _NORMAL_DROPOFF_TS 1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define ATTRIBUTES_NEED_NORMAL
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define ATTRIBUTES_NEED_TANGENT
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define ATTRIBUTES_NEED_TEXCOORD0
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define ATTRIBUTES_NEED_TEXCOORD1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define ATTRIBUTES_NEED_TEXCOORD2
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define VARYINGS_NEED_POSITION_WS
            #endif
    
                #define FEATURES_GRAPH_VERTEX
                /* WARNING: $splice Could not find named fragment 'PassInstancing' */
                #define SHADERPASS SHADERPASS_META
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #define REQUIRE_DEPTH_TEXTURE
                #endif
                /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
    
                // Includes
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/MetaInput.hlsl"
    
                // --------------------------------------------------
                // Structs and Packing
    
                struct Attributes
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 positionOS : POSITION;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 normalOS : NORMAL;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 tangentOS : TANGENT;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 uv0 : TEXCOORD0;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 uv1 : TEXCOORD1;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 uv2 : TEXCOORD2;
                    #endif
                    #if UNITY_ANY_INSTANCING_ENABLED
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint instanceID : INSTANCEID_SEMANTIC;
                    #endif
                    #endif
                };
                struct Varyings
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 positionCS : SV_POSITION;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 positionWS;
                    #endif
                    #if UNITY_ANY_INSTANCING_ENABLED
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                    #endif
                };
                struct SurfaceDescriptionInputs
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpacePosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 ScreenPosition;
                    #endif
                };
                struct VertexDescriptionInputs
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 ObjectSpaceNormal;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpaceNormal;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 ObjectSpaceTangent;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpaceTangent;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 ObjectSpaceBiTangent;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpaceBiTangent;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 ObjectSpacePosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpacePosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 uv0;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 TimeParameters;
                    #endif
                };
                struct PackedVaryings
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 positionCS : SV_POSITION;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 interp0 : TEXCOORD0;
                    #endif
                    #if UNITY_ANY_INSTANCING_ENABLED
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                    #endif
                };
    
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                PackedVaryings PackVaryings (Varyings input)
                    {
                        PackedVaryings output;
                        output.positionCS = input.positionCS;
                        output.interp0.xyz =  input.positionWS;
                        #if UNITY_ANY_INSTANCING_ENABLED
                        output.instanceID = input.instanceID;
                        #endif
                        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                        #endif
                        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                        #endif
                        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                        output.cullFace = input.cullFace;
                        #endif
                        return output;
                    }
                    Varyings UnpackVaryings (PackedVaryings input)
                    {
                        Varyings output;
                        output.positionCS = input.positionCS;
                        output.positionWS = input.interp0.xyz;
                        #if UNITY_ANY_INSTANCING_ENABLED
                        output.instanceID = input.instanceID;
                        #endif
                        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                        #endif
                        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                        #endif
                        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                        output.cullFace = input.cullFace;
                        #endif
                        return output;
                    }
                #endif
    
                // --------------------------------------------------
                // Graph
    
                // Graph Properties
                CBUFFER_START(UnityPerMaterial)
                float _depth;
                float _depthStrength;
                float4 _deepWaterColor;
                float4 _shallowWaterColor;
                float _smoothness;
                float _normalStrength;
                float _normalTiling;
                float _normalSpeed;
                float3 _mainNormalDirection;
                float3 _secondNormalDirection;
                float _amplitude;
                float _waves;
                float _wavesSpeed;
                CBUFFER_END
                TEXTURE2D(_mainNormal); SAMPLER(sampler_mainNormal); float4 _mainNormal_TexelSize;
                TEXTURE2D(_secondNormal); SAMPLER(sampler_secondNormal); float4 _secondNormal_TexelSize;
    
                // Graph Functions
                
                void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A / B;
                }
                
                void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                {
                    Out = UV * Tiling + Offset;
                }
                
                
                float2 Unity_GradientNoise_Dir_float(float2 p)
                {
                    // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
                    p = p % 289;
                    // need full precision, otherwise half overflows when p > 1
                    float x = float(34 * p.x + 1) * p.x % 289 + p.y;
                    x = (34 * x + 1) * x % 289;
                    x = frac(x / 41) * 2 - 1;
                    return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
                }
                
                void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
                { 
                    float2 p = UV * Scale;
                    float2 ip = floor(p);
                    float2 fp = frac(p);
                    float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
                    float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
                    float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
                    float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
                    fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
                    Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
                }
                
                void Unity_Add_float(float A, float B, out float Out)
                {
                    Out = A + B;
                }
                
                void Unity_Divide_float(float A, float B, out float Out)
                {
                    Out = A / B;
                }
                
                void Unity_Subtract_float(float A, float B, out float Out)
                {
                    Out = A - B;
                }
                
                void Unity_Multiply_float(float A, float B, out float Out)
                {
                    Out = A * B;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_SceneDepth_Linear01_float(float4 UV, out float Out)
                {
                    Out = Linear01Depth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
                }
                
                void Unity_Clamp_float(float In, float Min, float Max, out float Out)
                {
                    Out = clamp(In, Min, Max);
                }
                
                void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
                {
                    Out = lerp(A, B, T);
                }
    
                // Graph Vertex
                struct VertexDescription
                {
                    float3 Position;
                    float3 Normal;
                    float3 Tangent;
                };
                
                VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                {
                    VertexDescription description = (VertexDescription)0;
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Split_ff0fd34a61f44fd7ae2f222441749bd9_R_1 = IN.WorldSpacePosition[0];
                    float _Split_ff0fd34a61f44fd7ae2f222441749bd9_G_2 = IN.WorldSpacePosition[1];
                    float _Split_ff0fd34a61f44fd7ae2f222441749bd9_B_3 = IN.WorldSpacePosition[2];
                    float _Split_ff0fd34a61f44fd7ae2f222441749bd9_A_4 = 0;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_f4af681ed89a4a3d8c81333e9f8b562d_Out_0 = _waves;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Property_49ef859bb89c4a8288c9eb1583334fde_Out_0 = _mainNormalDirection;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_992df1e5e71b4479bbb5a25e534d8861_Out_2;
                    Unity_Multiply_float((IN.TimeParameters.x.xxx), _Property_49ef859bb89c4a8288c9eb1583334fde_Out_0, _Multiply_992df1e5e71b4479bbb5a25e534d8861_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Vector1_60e9a38039a843989ca21ba08ba76bd7_Out_0 = 5;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Divide_eb274efe27a64e71ba9baa084548bb6c_Out_2;
                    Unity_Divide_float3(_Multiply_992df1e5e71b4479bbb5a25e534d8861_Out_2, (_Vector1_60e9a38039a843989ca21ba08ba76bd7_Out_0.xxx), _Divide_eb274efe27a64e71ba9baa084548bb6c_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_92f37cd5909d40809e2b672d1636bd54_Out_0 = _wavesSpeed;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_afb804d1277148d7b992f652bb14e3be_Out_2;
                    Unity_Multiply_float(_Divide_eb274efe27a64e71ba9baa084548bb6c_Out_2, (_Property_92f37cd5909d40809e2b672d1636bd54_Out_0.xxx), _Multiply_afb804d1277148d7b992f652bb14e3be_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float2 _TilingAndOffset_05baded2421248cd9222b83233309dcb_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, (_Property_f4af681ed89a4a3d8c81333e9f8b562d_Out_0.xx), (_Multiply_afb804d1277148d7b992f652bb14e3be_Out_2.xy), _TilingAndOffset_05baded2421248cd9222b83233309dcb_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _GradientNoise_5b5f40a249b347c9be3b4afc6d0ed3ad_Out_2;
                    Unity_GradientNoise_float(_TilingAndOffset_05baded2421248cd9222b83233309dcb_Out_3, 10, _GradientNoise_5b5f40a249b347c9be3b4afc6d0ed3ad_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Property_666f9a531b564538acc376057bc6caa9_Out_0 = _secondNormalDirection;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_118898149cbd4850b0807b9467ed73b4_Out_2;
                    Unity_Multiply_float((IN.TimeParameters.x.xxx), _Property_666f9a531b564538acc376057bc6caa9_Out_0, _Multiply_118898149cbd4850b0807b9467ed73b4_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Vector1_ea96af95fe4f4961ad8bfc89f5bc9a03_Out_0 = 5;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Divide_b7c139d64ea9401fbda3a903c9fd1bf6_Out_2;
                    Unity_Divide_float3(_Multiply_118898149cbd4850b0807b9467ed73b4_Out_2, (_Vector1_ea96af95fe4f4961ad8bfc89f5bc9a03_Out_0.xxx), _Divide_b7c139d64ea9401fbda3a903c9fd1bf6_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_6199970682ac4c9c947732b8aa1e32b0_Out_2;
                    Unity_Multiply_float(_Divide_b7c139d64ea9401fbda3a903c9fd1bf6_Out_2, (_Property_92f37cd5909d40809e2b672d1636bd54_Out_0.xxx), _Multiply_6199970682ac4c9c947732b8aa1e32b0_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float2 _TilingAndOffset_2d869c568f8c4bd1935e9e1a5d383ff4_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, (_Property_f4af681ed89a4a3d8c81333e9f8b562d_Out_0.xx), (_Multiply_6199970682ac4c9c947732b8aa1e32b0_Out_2.xy), _TilingAndOffset_2d869c568f8c4bd1935e9e1a5d383ff4_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _GradientNoise_7d50ab18cca7435cbe45ace0410a84c7_Out_2;
                    Unity_GradientNoise_float(_TilingAndOffset_2d869c568f8c4bd1935e9e1a5d383ff4_Out_3, 10, _GradientNoise_7d50ab18cca7435cbe45ace0410a84c7_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Add_3ab7d42c644a4df381d663f07b7ab1e9_Out_2;
                    Unity_Add_float(_GradientNoise_5b5f40a249b347c9be3b4afc6d0ed3ad_Out_2, _GradientNoise_7d50ab18cca7435cbe45ace0410a84c7_Out_2, _Add_3ab7d42c644a4df381d663f07b7ab1e9_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Divide_cefb6bacdd4e476ea8103edefe43f584_Out_2;
                    Unity_Divide_float(_Add_3ab7d42c644a4df381d663f07b7ab1e9_Out_2, 2, _Divide_cefb6bacdd4e476ea8103edefe43f584_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Subtract_4da7b6862bcc45eca57cbd26b806eaf0_Out_2;
                    Unity_Subtract_float(_Divide_cefb6bacdd4e476ea8103edefe43f584_Out_2, 0.61, _Subtract_4da7b6862bcc45eca57cbd26b806eaf0_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_ce933f1cb0934b47a86069374aea82d8_Out_0 = _amplitude;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Multiply_fc80491e653843f7b95b7d963584d21d_Out_2;
                    Unity_Multiply_float(_Subtract_4da7b6862bcc45eca57cbd26b806eaf0_Out_2, _Property_ce933f1cb0934b47a86069374aea82d8_Out_0, _Multiply_fc80491e653843f7b95b7d963584d21d_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Combine_4394e5327dea4ebda9c6b40c020e0721_RGBA_4;
                    float3 _Combine_4394e5327dea4ebda9c6b40c020e0721_RGB_5;
                    float2 _Combine_4394e5327dea4ebda9c6b40c020e0721_RG_6;
                    Unity_Combine_float(_Split_ff0fd34a61f44fd7ae2f222441749bd9_R_1, _Multiply_fc80491e653843f7b95b7d963584d21d_Out_2, _Split_ff0fd34a61f44fd7ae2f222441749bd9_B_3, 0, _Combine_4394e5327dea4ebda9c6b40c020e0721_RGBA_4, _Combine_4394e5327dea4ebda9c6b40c020e0721_RGB_5, _Combine_4394e5327dea4ebda9c6b40c020e0721_RG_6);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Transform_5f6d055972de4e69871e05659dc0cf87_Out_1 = TransformWorldToObject(_Combine_4394e5327dea4ebda9c6b40c020e0721_RGB_5.xyz);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Combine_989bd6296fa44c898dce3b24fde18c9d_RGBA_4;
                    float3 _Combine_989bd6296fa44c898dce3b24fde18c9d_RGB_5;
                    float2 _Combine_989bd6296fa44c898dce3b24fde18c9d_RG_6;
                    Unity_Combine_float(_Split_ff0fd34a61f44fd7ae2f222441749bd9_R_1, _Split_ff0fd34a61f44fd7ae2f222441749bd9_G_2, _Split_ff0fd34a61f44fd7ae2f222441749bd9_B_3, 0, _Combine_989bd6296fa44c898dce3b24fde18c9d_RGBA_4, _Combine_989bd6296fa44c898dce3b24fde18c9d_RGB_5, _Combine_989bd6296fa44c898dce3b24fde18c9d_RG_6);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    #if defined(BOOLEAN_2D5E488208064DEDBE97E09FA59744E9_ON)
                    float3 _Waving_e9c7407f61464da88e74e85183ca2065_Out_0 = _Transform_5f6d055972de4e69871e05659dc0cf87_Out_1;
                    #else
                    float3 _Waving_e9c7407f61464da88e74e85183ca2065_Out_0 = _Combine_989bd6296fa44c898dce3b24fde18c9d_RGB_5;
                    #endif
                    #endif
                    description.Position = _Waving_e9c7407f61464da88e74e85183ca2065_Out_0;
                    description.Normal = IN.ObjectSpaceNormal;
                    description.Tangent = IN.ObjectSpaceTangent;
                    return description;
                }
    
                // Graph Pixel
                struct SurfaceDescription
                {
                    float3 BaseColor;
                    float3 Emission;
                    float Alpha;
                    float AlphaClipThreshold;
                };
                
                SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                {
                    SurfaceDescription surface = (SurfaceDescription)0;
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Property_cd262e3649c94d36ac1a6035934c82ba_Out_0 = _shallowWaterColor;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Property_c08d4525fbf641d78eb168f9e6c77374_Out_0 = _deepWaterColor;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _SceneDepth_ff2814420f634b6c9006b17db1b0db86_Out_1;
                    Unity_SceneDepth_Linear01_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_ff2814420f634b6c9006b17db1b0db86_Out_1);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Multiply_7fe029570de94c259af598c01f1e9fc7_Out_2;
                    Unity_Multiply_float(_SceneDepth_ff2814420f634b6c9006b17db1b0db86_Out_1, _ProjectionParams.z, _Multiply_7fe029570de94c259af598c01f1e9fc7_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_69b3cbbc42e345ba9fcd9de510b5e2d7_Out_0 = _depth;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0 = IN.ScreenPosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Split_4da6c10dd6e44537a1e2021901925b9e_R_1 = _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0[0];
                    float _Split_4da6c10dd6e44537a1e2021901925b9e_G_2 = _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0[1];
                    float _Split_4da6c10dd6e44537a1e2021901925b9e_B_3 = _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0[2];
                    float _Split_4da6c10dd6e44537a1e2021901925b9e_A_4 = _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0[3];
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Add_5516261d5322477cbf6c851a3128394f_Out_2;
                    Unity_Add_float(_Property_69b3cbbc42e345ba9fcd9de510b5e2d7_Out_0, _Split_4da6c10dd6e44537a1e2021901925b9e_A_4, _Add_5516261d5322477cbf6c851a3128394f_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Subtract_f153dba44eeb4c808ffd45ea4a4f742e_Out_2;
                    Unity_Subtract_float(_Multiply_7fe029570de94c259af598c01f1e9fc7_Out_2, _Add_5516261d5322477cbf6c851a3128394f_Out_2, _Subtract_f153dba44eeb4c808ffd45ea4a4f742e_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_3b327dff25184e83be825e3db1854a26_Out_0 = _depthStrength;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Multiply_bcf5cd29cecf4b4f97083346027d340a_Out_2;
                    Unity_Multiply_float(_Subtract_f153dba44eeb4c808ffd45ea4a4f742e_Out_2, _Property_3b327dff25184e83be825e3db1854a26_Out_0, _Multiply_bcf5cd29cecf4b4f97083346027d340a_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Clamp_07516fbacac148a2ab07ae8f0615108e_Out_3;
                    Unity_Clamp_float(_Multiply_bcf5cd29cecf4b4f97083346027d340a_Out_2, 0, 1, _Clamp_07516fbacac148a2ab07ae8f0615108e_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3;
                    Unity_Lerp_float4(_Property_cd262e3649c94d36ac1a6035934c82ba_Out_0, _Property_c08d4525fbf641d78eb168f9e6c77374_Out_0, (_Clamp_07516fbacac148a2ab07ae8f0615108e_Out_3.xxxx), _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Split_5dc8f38583ee40c19b6f09138a95e012_R_1 = _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3[0];
                    float _Split_5dc8f38583ee40c19b6f09138a95e012_G_2 = _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3[1];
                    float _Split_5dc8f38583ee40c19b6f09138a95e012_B_3 = _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3[2];
                    float _Split_5dc8f38583ee40c19b6f09138a95e012_A_4 = _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3[3];
                    #endif
                    surface.BaseColor = (_Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3.xyz);
                    surface.Emission = float3(0, 0, 0);
                    surface.Alpha = _Split_5dc8f38583ee40c19b6f09138a95e012_A_4;
                    surface.AlphaClipThreshold = 0;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ObjectSpaceNormal =           input.normalOS;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ObjectSpaceTangent =          input.tangentOS;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ObjectSpacePosition =         input.positionOS;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpacePosition =          TransformObjectToWorld(input.positionOS);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.uv0 =                         input.uv0;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.TimeParameters =              _TimeParameters.xyz;
                #endif
                
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                
                
                
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpacePosition =          input.positionWS;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
                #endif
                
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
                #else
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                #endif
                #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                
                    return output;
                }
                
    
                // --------------------------------------------------
                // Main
    
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/LightingMetaPass.hlsl"
    
                ENDHLSL
            }
            Pass
            {
                // Name: <None>
                Tags
                {
                    "LightMode" = "Universal2D"
                }
    
                // Render State
                Cull Back
                Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
                ZTest LEqual
                ZWrite Off
    
                // Debug
                // <None>
    
                // --------------------------------------------------
                // Pass
    
                HLSLPROGRAM
    
                // Pragmas
                #pragma target 2.0
                #pragma only_renderers gles gles3
                #pragma multi_compile_instancing
                #pragma prefer_hlslcc gles
                #pragma vertex vert
                #pragma fragment frag
    
                // DotsInstancingOptions: <None>
                // HybridV1InjectedBuiltinProperties: <None>
    
                // Keywords
                // PassKeywords: <None>
                #pragma shader_feature_local _ BOOLEAN_2D5E488208064DEDBE97E09FA59744E9_ON
                
                #if defined(BOOLEAN_2D5E488208064DEDBE97E09FA59744E9_ON)
                    #define KEYWORD_PERMUTATION_0
                #else
                    #define KEYWORD_PERMUTATION_1
                #endif
                
    
                // Defines
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define _SURFACE_TYPE_TRANSPARENT 1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define _AlphaClip 1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define _NORMALMAP 1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define _NORMAL_DROPOFF_TS 1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define ATTRIBUTES_NEED_NORMAL
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define ATTRIBUTES_NEED_TANGENT
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define ATTRIBUTES_NEED_TEXCOORD0
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define VARYINGS_NEED_POSITION_WS
            #endif
    
                #define FEATURES_GRAPH_VERTEX
                /* WARNING: $splice Could not find named fragment 'PassInstancing' */
                #define SHADERPASS SHADERPASS_2D
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #define REQUIRE_DEPTH_TEXTURE
                #endif
                /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
    
                // Includes
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
    
                // --------------------------------------------------
                // Structs and Packing
    
                struct Attributes
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 positionOS : POSITION;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 normalOS : NORMAL;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 tangentOS : TANGENT;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 uv0 : TEXCOORD0;
                    #endif
                    #if UNITY_ANY_INSTANCING_ENABLED
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint instanceID : INSTANCEID_SEMANTIC;
                    #endif
                    #endif
                };
                struct Varyings
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 positionCS : SV_POSITION;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 positionWS;
                    #endif
                    #if UNITY_ANY_INSTANCING_ENABLED
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                    #endif
                };
                struct SurfaceDescriptionInputs
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpacePosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 ScreenPosition;
                    #endif
                };
                struct VertexDescriptionInputs
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 ObjectSpaceNormal;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpaceNormal;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 ObjectSpaceTangent;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpaceTangent;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 ObjectSpaceBiTangent;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpaceBiTangent;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 ObjectSpacePosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpacePosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 uv0;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 TimeParameters;
                    #endif
                };
                struct PackedVaryings
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 positionCS : SV_POSITION;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 interp0 : TEXCOORD0;
                    #endif
                    #if UNITY_ANY_INSTANCING_ENABLED
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                    #endif
                };
    
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                PackedVaryings PackVaryings (Varyings input)
                    {
                        PackedVaryings output;
                        output.positionCS = input.positionCS;
                        output.interp0.xyz =  input.positionWS;
                        #if UNITY_ANY_INSTANCING_ENABLED
                        output.instanceID = input.instanceID;
                        #endif
                        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                        #endif
                        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                        #endif
                        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                        output.cullFace = input.cullFace;
                        #endif
                        return output;
                    }
                    Varyings UnpackVaryings (PackedVaryings input)
                    {
                        Varyings output;
                        output.positionCS = input.positionCS;
                        output.positionWS = input.interp0.xyz;
                        #if UNITY_ANY_INSTANCING_ENABLED
                        output.instanceID = input.instanceID;
                        #endif
                        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                        #endif
                        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                        #endif
                        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                        output.cullFace = input.cullFace;
                        #endif
                        return output;
                    }
                #endif
    
                // --------------------------------------------------
                // Graph
    
                // Graph Properties
                CBUFFER_START(UnityPerMaterial)
                float _depth;
                float _depthStrength;
                float4 _deepWaterColor;
                float4 _shallowWaterColor;
                float _smoothness;
                float _normalStrength;
                float _normalTiling;
                float _normalSpeed;
                float3 _mainNormalDirection;
                float3 _secondNormalDirection;
                float _amplitude;
                float _waves;
                float _wavesSpeed;
                CBUFFER_END
                TEXTURE2D(_mainNormal); SAMPLER(sampler_mainNormal); float4 _mainNormal_TexelSize;
                TEXTURE2D(_secondNormal); SAMPLER(sampler_secondNormal); float4 _secondNormal_TexelSize;
    
                // Graph Functions
                
                void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A / B;
                }
                
                void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                {
                    Out = UV * Tiling + Offset;
                }
                
                
                float2 Unity_GradientNoise_Dir_float(float2 p)
                {
                    // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
                    p = p % 289;
                    // need full precision, otherwise half overflows when p > 1
                    float x = float(34 * p.x + 1) * p.x % 289 + p.y;
                    x = (34 * x + 1) * x % 289;
                    x = frac(x / 41) * 2 - 1;
                    return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
                }
                
                void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
                { 
                    float2 p = UV * Scale;
                    float2 ip = floor(p);
                    float2 fp = frac(p);
                    float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
                    float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
                    float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
                    float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
                    fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
                    Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
                }
                
                void Unity_Add_float(float A, float B, out float Out)
                {
                    Out = A + B;
                }
                
                void Unity_Divide_float(float A, float B, out float Out)
                {
                    Out = A / B;
                }
                
                void Unity_Subtract_float(float A, float B, out float Out)
                {
                    Out = A - B;
                }
                
                void Unity_Multiply_float(float A, float B, out float Out)
                {
                    Out = A * B;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_SceneDepth_Linear01_float(float4 UV, out float Out)
                {
                    Out = Linear01Depth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
                }
                
                void Unity_Clamp_float(float In, float Min, float Max, out float Out)
                {
                    Out = clamp(In, Min, Max);
                }
                
                void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
                {
                    Out = lerp(A, B, T);
                }
    
                // Graph Vertex
                struct VertexDescription
                {
                    float3 Position;
                    float3 Normal;
                    float3 Tangent;
                };
                
                VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                {
                    VertexDescription description = (VertexDescription)0;
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Split_ff0fd34a61f44fd7ae2f222441749bd9_R_1 = IN.WorldSpacePosition[0];
                    float _Split_ff0fd34a61f44fd7ae2f222441749bd9_G_2 = IN.WorldSpacePosition[1];
                    float _Split_ff0fd34a61f44fd7ae2f222441749bd9_B_3 = IN.WorldSpacePosition[2];
                    float _Split_ff0fd34a61f44fd7ae2f222441749bd9_A_4 = 0;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_f4af681ed89a4a3d8c81333e9f8b562d_Out_0 = _waves;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Property_49ef859bb89c4a8288c9eb1583334fde_Out_0 = _mainNormalDirection;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_992df1e5e71b4479bbb5a25e534d8861_Out_2;
                    Unity_Multiply_float((IN.TimeParameters.x.xxx), _Property_49ef859bb89c4a8288c9eb1583334fde_Out_0, _Multiply_992df1e5e71b4479bbb5a25e534d8861_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Vector1_60e9a38039a843989ca21ba08ba76bd7_Out_0 = 5;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Divide_eb274efe27a64e71ba9baa084548bb6c_Out_2;
                    Unity_Divide_float3(_Multiply_992df1e5e71b4479bbb5a25e534d8861_Out_2, (_Vector1_60e9a38039a843989ca21ba08ba76bd7_Out_0.xxx), _Divide_eb274efe27a64e71ba9baa084548bb6c_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_92f37cd5909d40809e2b672d1636bd54_Out_0 = _wavesSpeed;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_afb804d1277148d7b992f652bb14e3be_Out_2;
                    Unity_Multiply_float(_Divide_eb274efe27a64e71ba9baa084548bb6c_Out_2, (_Property_92f37cd5909d40809e2b672d1636bd54_Out_0.xxx), _Multiply_afb804d1277148d7b992f652bb14e3be_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float2 _TilingAndOffset_05baded2421248cd9222b83233309dcb_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, (_Property_f4af681ed89a4a3d8c81333e9f8b562d_Out_0.xx), (_Multiply_afb804d1277148d7b992f652bb14e3be_Out_2.xy), _TilingAndOffset_05baded2421248cd9222b83233309dcb_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _GradientNoise_5b5f40a249b347c9be3b4afc6d0ed3ad_Out_2;
                    Unity_GradientNoise_float(_TilingAndOffset_05baded2421248cd9222b83233309dcb_Out_3, 10, _GradientNoise_5b5f40a249b347c9be3b4afc6d0ed3ad_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Property_666f9a531b564538acc376057bc6caa9_Out_0 = _secondNormalDirection;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_118898149cbd4850b0807b9467ed73b4_Out_2;
                    Unity_Multiply_float((IN.TimeParameters.x.xxx), _Property_666f9a531b564538acc376057bc6caa9_Out_0, _Multiply_118898149cbd4850b0807b9467ed73b4_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Vector1_ea96af95fe4f4961ad8bfc89f5bc9a03_Out_0 = 5;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Divide_b7c139d64ea9401fbda3a903c9fd1bf6_Out_2;
                    Unity_Divide_float3(_Multiply_118898149cbd4850b0807b9467ed73b4_Out_2, (_Vector1_ea96af95fe4f4961ad8bfc89f5bc9a03_Out_0.xxx), _Divide_b7c139d64ea9401fbda3a903c9fd1bf6_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_6199970682ac4c9c947732b8aa1e32b0_Out_2;
                    Unity_Multiply_float(_Divide_b7c139d64ea9401fbda3a903c9fd1bf6_Out_2, (_Property_92f37cd5909d40809e2b672d1636bd54_Out_0.xxx), _Multiply_6199970682ac4c9c947732b8aa1e32b0_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float2 _TilingAndOffset_2d869c568f8c4bd1935e9e1a5d383ff4_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, (_Property_f4af681ed89a4a3d8c81333e9f8b562d_Out_0.xx), (_Multiply_6199970682ac4c9c947732b8aa1e32b0_Out_2.xy), _TilingAndOffset_2d869c568f8c4bd1935e9e1a5d383ff4_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _GradientNoise_7d50ab18cca7435cbe45ace0410a84c7_Out_2;
                    Unity_GradientNoise_float(_TilingAndOffset_2d869c568f8c4bd1935e9e1a5d383ff4_Out_3, 10, _GradientNoise_7d50ab18cca7435cbe45ace0410a84c7_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Add_3ab7d42c644a4df381d663f07b7ab1e9_Out_2;
                    Unity_Add_float(_GradientNoise_5b5f40a249b347c9be3b4afc6d0ed3ad_Out_2, _GradientNoise_7d50ab18cca7435cbe45ace0410a84c7_Out_2, _Add_3ab7d42c644a4df381d663f07b7ab1e9_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Divide_cefb6bacdd4e476ea8103edefe43f584_Out_2;
                    Unity_Divide_float(_Add_3ab7d42c644a4df381d663f07b7ab1e9_Out_2, 2, _Divide_cefb6bacdd4e476ea8103edefe43f584_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Subtract_4da7b6862bcc45eca57cbd26b806eaf0_Out_2;
                    Unity_Subtract_float(_Divide_cefb6bacdd4e476ea8103edefe43f584_Out_2, 0.61, _Subtract_4da7b6862bcc45eca57cbd26b806eaf0_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_ce933f1cb0934b47a86069374aea82d8_Out_0 = _amplitude;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Multiply_fc80491e653843f7b95b7d963584d21d_Out_2;
                    Unity_Multiply_float(_Subtract_4da7b6862bcc45eca57cbd26b806eaf0_Out_2, _Property_ce933f1cb0934b47a86069374aea82d8_Out_0, _Multiply_fc80491e653843f7b95b7d963584d21d_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Combine_4394e5327dea4ebda9c6b40c020e0721_RGBA_4;
                    float3 _Combine_4394e5327dea4ebda9c6b40c020e0721_RGB_5;
                    float2 _Combine_4394e5327dea4ebda9c6b40c020e0721_RG_6;
                    Unity_Combine_float(_Split_ff0fd34a61f44fd7ae2f222441749bd9_R_1, _Multiply_fc80491e653843f7b95b7d963584d21d_Out_2, _Split_ff0fd34a61f44fd7ae2f222441749bd9_B_3, 0, _Combine_4394e5327dea4ebda9c6b40c020e0721_RGBA_4, _Combine_4394e5327dea4ebda9c6b40c020e0721_RGB_5, _Combine_4394e5327dea4ebda9c6b40c020e0721_RG_6);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Transform_5f6d055972de4e69871e05659dc0cf87_Out_1 = TransformWorldToObject(_Combine_4394e5327dea4ebda9c6b40c020e0721_RGB_5.xyz);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Combine_989bd6296fa44c898dce3b24fde18c9d_RGBA_4;
                    float3 _Combine_989bd6296fa44c898dce3b24fde18c9d_RGB_5;
                    float2 _Combine_989bd6296fa44c898dce3b24fde18c9d_RG_6;
                    Unity_Combine_float(_Split_ff0fd34a61f44fd7ae2f222441749bd9_R_1, _Split_ff0fd34a61f44fd7ae2f222441749bd9_G_2, _Split_ff0fd34a61f44fd7ae2f222441749bd9_B_3, 0, _Combine_989bd6296fa44c898dce3b24fde18c9d_RGBA_4, _Combine_989bd6296fa44c898dce3b24fde18c9d_RGB_5, _Combine_989bd6296fa44c898dce3b24fde18c9d_RG_6);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    #if defined(BOOLEAN_2D5E488208064DEDBE97E09FA59744E9_ON)
                    float3 _Waving_e9c7407f61464da88e74e85183ca2065_Out_0 = _Transform_5f6d055972de4e69871e05659dc0cf87_Out_1;
                    #else
                    float3 _Waving_e9c7407f61464da88e74e85183ca2065_Out_0 = _Combine_989bd6296fa44c898dce3b24fde18c9d_RGB_5;
                    #endif
                    #endif
                    description.Position = _Waving_e9c7407f61464da88e74e85183ca2065_Out_0;
                    description.Normal = IN.ObjectSpaceNormal;
                    description.Tangent = IN.ObjectSpaceTangent;
                    return description;
                }
    
                // Graph Pixel
                struct SurfaceDescription
                {
                    float3 BaseColor;
                    float Alpha;
                    float AlphaClipThreshold;
                };
                
                SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                {
                    SurfaceDescription surface = (SurfaceDescription)0;
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Property_cd262e3649c94d36ac1a6035934c82ba_Out_0 = _shallowWaterColor;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Property_c08d4525fbf641d78eb168f9e6c77374_Out_0 = _deepWaterColor;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _SceneDepth_ff2814420f634b6c9006b17db1b0db86_Out_1;
                    Unity_SceneDepth_Linear01_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_ff2814420f634b6c9006b17db1b0db86_Out_1);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Multiply_7fe029570de94c259af598c01f1e9fc7_Out_2;
                    Unity_Multiply_float(_SceneDepth_ff2814420f634b6c9006b17db1b0db86_Out_1, _ProjectionParams.z, _Multiply_7fe029570de94c259af598c01f1e9fc7_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_69b3cbbc42e345ba9fcd9de510b5e2d7_Out_0 = _depth;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0 = IN.ScreenPosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Split_4da6c10dd6e44537a1e2021901925b9e_R_1 = _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0[0];
                    float _Split_4da6c10dd6e44537a1e2021901925b9e_G_2 = _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0[1];
                    float _Split_4da6c10dd6e44537a1e2021901925b9e_B_3 = _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0[2];
                    float _Split_4da6c10dd6e44537a1e2021901925b9e_A_4 = _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0[3];
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Add_5516261d5322477cbf6c851a3128394f_Out_2;
                    Unity_Add_float(_Property_69b3cbbc42e345ba9fcd9de510b5e2d7_Out_0, _Split_4da6c10dd6e44537a1e2021901925b9e_A_4, _Add_5516261d5322477cbf6c851a3128394f_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Subtract_f153dba44eeb4c808ffd45ea4a4f742e_Out_2;
                    Unity_Subtract_float(_Multiply_7fe029570de94c259af598c01f1e9fc7_Out_2, _Add_5516261d5322477cbf6c851a3128394f_Out_2, _Subtract_f153dba44eeb4c808ffd45ea4a4f742e_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_3b327dff25184e83be825e3db1854a26_Out_0 = _depthStrength;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Multiply_bcf5cd29cecf4b4f97083346027d340a_Out_2;
                    Unity_Multiply_float(_Subtract_f153dba44eeb4c808ffd45ea4a4f742e_Out_2, _Property_3b327dff25184e83be825e3db1854a26_Out_0, _Multiply_bcf5cd29cecf4b4f97083346027d340a_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Clamp_07516fbacac148a2ab07ae8f0615108e_Out_3;
                    Unity_Clamp_float(_Multiply_bcf5cd29cecf4b4f97083346027d340a_Out_2, 0, 1, _Clamp_07516fbacac148a2ab07ae8f0615108e_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3;
                    Unity_Lerp_float4(_Property_cd262e3649c94d36ac1a6035934c82ba_Out_0, _Property_c08d4525fbf641d78eb168f9e6c77374_Out_0, (_Clamp_07516fbacac148a2ab07ae8f0615108e_Out_3.xxxx), _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Split_5dc8f38583ee40c19b6f09138a95e012_R_1 = _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3[0];
                    float _Split_5dc8f38583ee40c19b6f09138a95e012_G_2 = _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3[1];
                    float _Split_5dc8f38583ee40c19b6f09138a95e012_B_3 = _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3[2];
                    float _Split_5dc8f38583ee40c19b6f09138a95e012_A_4 = _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3[3];
                    #endif
                    surface.BaseColor = (_Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3.xyz);
                    surface.Alpha = _Split_5dc8f38583ee40c19b6f09138a95e012_A_4;
                    surface.AlphaClipThreshold = 0;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ObjectSpaceNormal =           input.normalOS;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ObjectSpaceTangent =          input.tangentOS;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ObjectSpacePosition =         input.positionOS;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpacePosition =          TransformObjectToWorld(input.positionOS);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.uv0 =                         input.uv0;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.TimeParameters =              _TimeParameters.xyz;
                #endif
                
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                
                
                
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpacePosition =          input.positionWS;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
                #endif
                
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
                #else
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                #endif
                #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                
                    return output;
                }
                
    
                // --------------------------------------------------
                // Main
    
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBR2DPass.hlsl"
    
                ENDHLSL
            }
        }
        SubShader
        {
            Tags
            {
                "RenderPipeline"="UniversalPipeline"
                "RenderType"="Transparent"
                "Queue"="Transparent"
            }
            Pass
            {
                Name "Universal Forward"
                Tags
                {
                    "LightMode" = "UniversalForward"
                }
    
                // Render State
                Cull Back
                Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
                ZTest LEqual
                ZWrite Off
    
                // Debug
                // <None>
    
                // --------------------------------------------------
                // Pass
    
                HLSLPROGRAM
    
                // Pragmas
                #pragma target 4.5
                #pragma exclude_renderers d3d11_9x gles
                #pragma multi_compile_instancing
                #pragma multi_compile_fog
                #pragma multi_compile _ DOTS_INSTANCING_ON
                #pragma vertex vert
                #pragma fragment frag
    
                // DotsInstancingOptions: <None>
                // HybridV1InjectedBuiltinProperties: <None>
    
                // Keywords
                #pragma multi_compile _ LIGHTMAP_ON
                #pragma multi_compile _ DIRLIGHTMAP_COMBINED
                #pragma multi_compile _ _MAIN_LIGHT_SHADOWS
                #pragma multi_compile _ _MAIN_LIGHT_SHADOWS_CASCADE
                #pragma multi_compile _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS _ADDITIONAL_OFF
                #pragma multi_compile _ _ADDITIONAL_LIGHT_SHADOWS
                #pragma multi_compile _ _SHADOWS_SOFT
                #pragma multi_compile _ _MIXED_LIGHTING_SUBTRACTIVE
                #pragma shader_feature_local _ BOOLEAN_2D5E488208064DEDBE97E09FA59744E9_ON
                
                #if defined(BOOLEAN_2D5E488208064DEDBE97E09FA59744E9_ON)
                    #define KEYWORD_PERMUTATION_0
                #else
                    #define KEYWORD_PERMUTATION_1
                #endif
                
    
                // Defines
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define _SURFACE_TYPE_TRANSPARENT 1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define _AlphaClip 1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define _NORMALMAP 1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define _NORMAL_DROPOFF_TS 1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define ATTRIBUTES_NEED_NORMAL
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define ATTRIBUTES_NEED_TANGENT
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define ATTRIBUTES_NEED_TEXCOORD0
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define ATTRIBUTES_NEED_TEXCOORD1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define VARYINGS_NEED_POSITION_WS
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define VARYINGS_NEED_NORMAL_WS
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define VARYINGS_NEED_TANGENT_WS
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define VARYINGS_NEED_TEXCOORD0
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define VARYINGS_NEED_VIEWDIRECTION_WS
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
            #endif
    
                #define FEATURES_GRAPH_VERTEX
                /* WARNING: $splice Could not find named fragment 'PassInstancing' */
                #define SHADERPASS SHADERPASS_FORWARD
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #define REQUIRE_DEPTH_TEXTURE
                #endif
                /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
    
                // Includes
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
    
                // --------------------------------------------------
                // Structs and Packing
    
                struct Attributes
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 positionOS : POSITION;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 normalOS : NORMAL;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 tangentOS : TANGENT;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 uv0 : TEXCOORD0;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 uv1 : TEXCOORD1;
                    #endif
                    #if UNITY_ANY_INSTANCING_ENABLED
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint instanceID : INSTANCEID_SEMANTIC;
                    #endif
                    #endif
                };
                struct Varyings
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 positionCS : SV_POSITION;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 positionWS;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 normalWS;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 tangentWS;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 texCoord0;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 viewDirectionWS;
                    #endif
                    #if defined(LIGHTMAP_ON)
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float2 lightmapUV;
                    #endif
                    #endif
                    #if !defined(LIGHTMAP_ON)
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 sh;
                    #endif
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 fogFactorAndVertexLight;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 shadowCoord;
                    #endif
                    #if UNITY_ANY_INSTANCING_ENABLED
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                    #endif
                };
                struct SurfaceDescriptionInputs
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 TangentSpaceNormal;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpacePosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 ScreenPosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 uv0;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 TimeParameters;
                    #endif
                };
                struct VertexDescriptionInputs
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 ObjectSpaceNormal;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpaceNormal;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 ObjectSpaceTangent;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpaceTangent;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 ObjectSpaceBiTangent;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpaceBiTangent;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 ObjectSpacePosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpacePosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 uv0;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 TimeParameters;
                    #endif
                };
                struct PackedVaryings
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 positionCS : SV_POSITION;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 interp0 : TEXCOORD0;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 interp1 : TEXCOORD1;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 interp2 : TEXCOORD2;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 interp3 : TEXCOORD3;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 interp4 : TEXCOORD4;
                    #endif
                    #if defined(LIGHTMAP_ON)
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float2 interp5 : TEXCOORD5;
                    #endif
                    #endif
                    #if !defined(LIGHTMAP_ON)
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 interp6 : TEXCOORD6;
                    #endif
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 interp7 : TEXCOORD7;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 interp8 : TEXCOORD8;
                    #endif
                    #if UNITY_ANY_INSTANCING_ENABLED
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                    #endif
                };
    
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                PackedVaryings PackVaryings (Varyings input)
                    {
                        PackedVaryings output;
                        output.positionCS = input.positionCS;
                        output.interp0.xyz =  input.positionWS;
                        output.interp1.xyz =  input.normalWS;
                        output.interp2.xyzw =  input.tangentWS;
                        output.interp3.xyzw =  input.texCoord0;
                        output.interp4.xyz =  input.viewDirectionWS;
                        #if defined(LIGHTMAP_ON)
                        output.interp5.xy =  input.lightmapUV;
                        #endif
                        #if !defined(LIGHTMAP_ON)
                        output.interp6.xyz =  input.sh;
                        #endif
                        output.interp7.xyzw =  input.fogFactorAndVertexLight;
                        output.interp8.xyzw =  input.shadowCoord;
                        #if UNITY_ANY_INSTANCING_ENABLED
                        output.instanceID = input.instanceID;
                        #endif
                        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                        #endif
                        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                        #endif
                        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                        output.cullFace = input.cullFace;
                        #endif
                        return output;
                    }
                    Varyings UnpackVaryings (PackedVaryings input)
                    {
                        Varyings output;
                        output.positionCS = input.positionCS;
                        output.positionWS = input.interp0.xyz;
                        output.normalWS = input.interp1.xyz;
                        output.tangentWS = input.interp2.xyzw;
                        output.texCoord0 = input.interp3.xyzw;
                        output.viewDirectionWS = input.interp4.xyz;
                        #if defined(LIGHTMAP_ON)
                        output.lightmapUV = input.interp5.xy;
                        #endif
                        #if !defined(LIGHTMAP_ON)
                        output.sh = input.interp6.xyz;
                        #endif
                        output.fogFactorAndVertexLight = input.interp7.xyzw;
                        output.shadowCoord = input.interp8.xyzw;
                        #if UNITY_ANY_INSTANCING_ENABLED
                        output.instanceID = input.instanceID;
                        #endif
                        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                        #endif
                        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                        #endif
                        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                        output.cullFace = input.cullFace;
                        #endif
                        return output;
                    }
                #endif
    
                // --------------------------------------------------
                // Graph
    
                // Graph Properties
                CBUFFER_START(UnityPerMaterial)
                float _depth;
                float _depthStrength;
                float4 _deepWaterColor;
                float4 _shallowWaterColor;
                float _smoothness;
                float _normalStrength;
                float _normalTiling;
                float _normalSpeed;
                float3 _mainNormalDirection;
                float3 _secondNormalDirection;
                float _amplitude;
                float _waves;
                float _wavesSpeed;
                CBUFFER_END
                TEXTURE2D(_mainNormal); SAMPLER(sampler_mainNormal); float4 _mainNormal_TexelSize;
                TEXTURE2D(_secondNormal); SAMPLER(sampler_secondNormal); float4 _secondNormal_TexelSize;
                SAMPLER(_SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_19fa380f103d42a49d00ac60250e471c_Sampler_3_Linear_Repeat);
    
                // Graph Functions
                
                void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A / B;
                }
                
                void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                {
                    Out = UV * Tiling + Offset;
                }
                
                
                float2 Unity_GradientNoise_Dir_float(float2 p)
                {
                    // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
                    p = p % 289;
                    // need full precision, otherwise half overflows when p > 1
                    float x = float(34 * p.x + 1) * p.x % 289 + p.y;
                    x = (34 * x + 1) * x % 289;
                    x = frac(x / 41) * 2 - 1;
                    return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
                }
                
                void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
                { 
                    float2 p = UV * Scale;
                    float2 ip = floor(p);
                    float2 fp = frac(p);
                    float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
                    float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
                    float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
                    float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
                    fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
                    Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
                }
                
                void Unity_Add_float(float A, float B, out float Out)
                {
                    Out = A + B;
                }
                
                void Unity_Divide_float(float A, float B, out float Out)
                {
                    Out = A / B;
                }
                
                void Unity_Subtract_float(float A, float B, out float Out)
                {
                    Out = A - B;
                }
                
                void Unity_Multiply_float(float A, float B, out float Out)
                {
                    Out = A * B;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_SceneDepth_Linear01_float(float4 UV, out float Out)
                {
                    Out = Linear01Depth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
                }
                
                void Unity_Clamp_float(float In, float Min, float Max, out float Out)
                {
                    Out = clamp(In, Min, Max);
                }
                
                void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
                {
                    Out = lerp(A, B, T);
                }
                
                void Unity_Add_float4(float4 A, float4 B, out float4 Out)
                {
                    Out = A + B;
                }
                
                void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
                {
                    Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
                }
    
                // Graph Vertex
                struct VertexDescription
                {
                    float3 Position;
                    float3 Normal;
                    float3 Tangent;
                };
                
                VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                {
                    VertexDescription description = (VertexDescription)0;
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Split_ff0fd34a61f44fd7ae2f222441749bd9_R_1 = IN.WorldSpacePosition[0];
                    float _Split_ff0fd34a61f44fd7ae2f222441749bd9_G_2 = IN.WorldSpacePosition[1];
                    float _Split_ff0fd34a61f44fd7ae2f222441749bd9_B_3 = IN.WorldSpacePosition[2];
                    float _Split_ff0fd34a61f44fd7ae2f222441749bd9_A_4 = 0;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_f4af681ed89a4a3d8c81333e9f8b562d_Out_0 = _waves;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Property_49ef859bb89c4a8288c9eb1583334fde_Out_0 = _mainNormalDirection;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_992df1e5e71b4479bbb5a25e534d8861_Out_2;
                    Unity_Multiply_float((IN.TimeParameters.x.xxx), _Property_49ef859bb89c4a8288c9eb1583334fde_Out_0, _Multiply_992df1e5e71b4479bbb5a25e534d8861_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Vector1_60e9a38039a843989ca21ba08ba76bd7_Out_0 = 5;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Divide_eb274efe27a64e71ba9baa084548bb6c_Out_2;
                    Unity_Divide_float3(_Multiply_992df1e5e71b4479bbb5a25e534d8861_Out_2, (_Vector1_60e9a38039a843989ca21ba08ba76bd7_Out_0.xxx), _Divide_eb274efe27a64e71ba9baa084548bb6c_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_92f37cd5909d40809e2b672d1636bd54_Out_0 = _wavesSpeed;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_afb804d1277148d7b992f652bb14e3be_Out_2;
                    Unity_Multiply_float(_Divide_eb274efe27a64e71ba9baa084548bb6c_Out_2, (_Property_92f37cd5909d40809e2b672d1636bd54_Out_0.xxx), _Multiply_afb804d1277148d7b992f652bb14e3be_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float2 _TilingAndOffset_05baded2421248cd9222b83233309dcb_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, (_Property_f4af681ed89a4a3d8c81333e9f8b562d_Out_0.xx), (_Multiply_afb804d1277148d7b992f652bb14e3be_Out_2.xy), _TilingAndOffset_05baded2421248cd9222b83233309dcb_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _GradientNoise_5b5f40a249b347c9be3b4afc6d0ed3ad_Out_2;
                    Unity_GradientNoise_float(_TilingAndOffset_05baded2421248cd9222b83233309dcb_Out_3, 10, _GradientNoise_5b5f40a249b347c9be3b4afc6d0ed3ad_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Property_666f9a531b564538acc376057bc6caa9_Out_0 = _secondNormalDirection;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_118898149cbd4850b0807b9467ed73b4_Out_2;
                    Unity_Multiply_float((IN.TimeParameters.x.xxx), _Property_666f9a531b564538acc376057bc6caa9_Out_0, _Multiply_118898149cbd4850b0807b9467ed73b4_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Vector1_ea96af95fe4f4961ad8bfc89f5bc9a03_Out_0 = 5;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Divide_b7c139d64ea9401fbda3a903c9fd1bf6_Out_2;
                    Unity_Divide_float3(_Multiply_118898149cbd4850b0807b9467ed73b4_Out_2, (_Vector1_ea96af95fe4f4961ad8bfc89f5bc9a03_Out_0.xxx), _Divide_b7c139d64ea9401fbda3a903c9fd1bf6_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_6199970682ac4c9c947732b8aa1e32b0_Out_2;
                    Unity_Multiply_float(_Divide_b7c139d64ea9401fbda3a903c9fd1bf6_Out_2, (_Property_92f37cd5909d40809e2b672d1636bd54_Out_0.xxx), _Multiply_6199970682ac4c9c947732b8aa1e32b0_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float2 _TilingAndOffset_2d869c568f8c4bd1935e9e1a5d383ff4_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, (_Property_f4af681ed89a4a3d8c81333e9f8b562d_Out_0.xx), (_Multiply_6199970682ac4c9c947732b8aa1e32b0_Out_2.xy), _TilingAndOffset_2d869c568f8c4bd1935e9e1a5d383ff4_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _GradientNoise_7d50ab18cca7435cbe45ace0410a84c7_Out_2;
                    Unity_GradientNoise_float(_TilingAndOffset_2d869c568f8c4bd1935e9e1a5d383ff4_Out_3, 10, _GradientNoise_7d50ab18cca7435cbe45ace0410a84c7_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Add_3ab7d42c644a4df381d663f07b7ab1e9_Out_2;
                    Unity_Add_float(_GradientNoise_5b5f40a249b347c9be3b4afc6d0ed3ad_Out_2, _GradientNoise_7d50ab18cca7435cbe45ace0410a84c7_Out_2, _Add_3ab7d42c644a4df381d663f07b7ab1e9_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Divide_cefb6bacdd4e476ea8103edefe43f584_Out_2;
                    Unity_Divide_float(_Add_3ab7d42c644a4df381d663f07b7ab1e9_Out_2, 2, _Divide_cefb6bacdd4e476ea8103edefe43f584_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Subtract_4da7b6862bcc45eca57cbd26b806eaf0_Out_2;
                    Unity_Subtract_float(_Divide_cefb6bacdd4e476ea8103edefe43f584_Out_2, 0.61, _Subtract_4da7b6862bcc45eca57cbd26b806eaf0_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_ce933f1cb0934b47a86069374aea82d8_Out_0 = _amplitude;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Multiply_fc80491e653843f7b95b7d963584d21d_Out_2;
                    Unity_Multiply_float(_Subtract_4da7b6862bcc45eca57cbd26b806eaf0_Out_2, _Property_ce933f1cb0934b47a86069374aea82d8_Out_0, _Multiply_fc80491e653843f7b95b7d963584d21d_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Combine_4394e5327dea4ebda9c6b40c020e0721_RGBA_4;
                    float3 _Combine_4394e5327dea4ebda9c6b40c020e0721_RGB_5;
                    float2 _Combine_4394e5327dea4ebda9c6b40c020e0721_RG_6;
                    Unity_Combine_float(_Split_ff0fd34a61f44fd7ae2f222441749bd9_R_1, _Multiply_fc80491e653843f7b95b7d963584d21d_Out_2, _Split_ff0fd34a61f44fd7ae2f222441749bd9_B_3, 0, _Combine_4394e5327dea4ebda9c6b40c020e0721_RGBA_4, _Combine_4394e5327dea4ebda9c6b40c020e0721_RGB_5, _Combine_4394e5327dea4ebda9c6b40c020e0721_RG_6);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Transform_5f6d055972de4e69871e05659dc0cf87_Out_1 = TransformWorldToObject(_Combine_4394e5327dea4ebda9c6b40c020e0721_RGB_5.xyz);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Combine_989bd6296fa44c898dce3b24fde18c9d_RGBA_4;
                    float3 _Combine_989bd6296fa44c898dce3b24fde18c9d_RGB_5;
                    float2 _Combine_989bd6296fa44c898dce3b24fde18c9d_RG_6;
                    Unity_Combine_float(_Split_ff0fd34a61f44fd7ae2f222441749bd9_R_1, _Split_ff0fd34a61f44fd7ae2f222441749bd9_G_2, _Split_ff0fd34a61f44fd7ae2f222441749bd9_B_3, 0, _Combine_989bd6296fa44c898dce3b24fde18c9d_RGBA_4, _Combine_989bd6296fa44c898dce3b24fde18c9d_RGB_5, _Combine_989bd6296fa44c898dce3b24fde18c9d_RG_6);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    #if defined(BOOLEAN_2D5E488208064DEDBE97E09FA59744E9_ON)
                    float3 _Waving_e9c7407f61464da88e74e85183ca2065_Out_0 = _Transform_5f6d055972de4e69871e05659dc0cf87_Out_1;
                    #else
                    float3 _Waving_e9c7407f61464da88e74e85183ca2065_Out_0 = _Combine_989bd6296fa44c898dce3b24fde18c9d_RGB_5;
                    #endif
                    #endif
                    description.Position = _Waving_e9c7407f61464da88e74e85183ca2065_Out_0;
                    description.Normal = IN.ObjectSpaceNormal;
                    description.Tangent = IN.ObjectSpaceTangent;
                    return description;
                }
    
                // Graph Pixel
                struct SurfaceDescription
                {
                    float3 BaseColor;
                    float3 NormalTS;
                    float3 Emission;
                    float Metallic;
                    float Smoothness;
                    float Occlusion;
                    float Alpha;
                    float AlphaClipThreshold;
                };
                
                SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                {
                    SurfaceDescription surface = (SurfaceDescription)0;
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Property_cd262e3649c94d36ac1a6035934c82ba_Out_0 = _shallowWaterColor;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Property_c08d4525fbf641d78eb168f9e6c77374_Out_0 = _deepWaterColor;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _SceneDepth_ff2814420f634b6c9006b17db1b0db86_Out_1;
                    Unity_SceneDepth_Linear01_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_ff2814420f634b6c9006b17db1b0db86_Out_1);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Multiply_7fe029570de94c259af598c01f1e9fc7_Out_2;
                    Unity_Multiply_float(_SceneDepth_ff2814420f634b6c9006b17db1b0db86_Out_1, _ProjectionParams.z, _Multiply_7fe029570de94c259af598c01f1e9fc7_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_69b3cbbc42e345ba9fcd9de510b5e2d7_Out_0 = _depth;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0 = IN.ScreenPosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Split_4da6c10dd6e44537a1e2021901925b9e_R_1 = _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0[0];
                    float _Split_4da6c10dd6e44537a1e2021901925b9e_G_2 = _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0[1];
                    float _Split_4da6c10dd6e44537a1e2021901925b9e_B_3 = _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0[2];
                    float _Split_4da6c10dd6e44537a1e2021901925b9e_A_4 = _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0[3];
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Add_5516261d5322477cbf6c851a3128394f_Out_2;
                    Unity_Add_float(_Property_69b3cbbc42e345ba9fcd9de510b5e2d7_Out_0, _Split_4da6c10dd6e44537a1e2021901925b9e_A_4, _Add_5516261d5322477cbf6c851a3128394f_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Subtract_f153dba44eeb4c808ffd45ea4a4f742e_Out_2;
                    Unity_Subtract_float(_Multiply_7fe029570de94c259af598c01f1e9fc7_Out_2, _Add_5516261d5322477cbf6c851a3128394f_Out_2, _Subtract_f153dba44eeb4c808ffd45ea4a4f742e_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_3b327dff25184e83be825e3db1854a26_Out_0 = _depthStrength;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Multiply_bcf5cd29cecf4b4f97083346027d340a_Out_2;
                    Unity_Multiply_float(_Subtract_f153dba44eeb4c808ffd45ea4a4f742e_Out_2, _Property_3b327dff25184e83be825e3db1854a26_Out_0, _Multiply_bcf5cd29cecf4b4f97083346027d340a_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Clamp_07516fbacac148a2ab07ae8f0615108e_Out_3;
                    Unity_Clamp_float(_Multiply_bcf5cd29cecf4b4f97083346027d340a_Out_2, 0, 1, _Clamp_07516fbacac148a2ab07ae8f0615108e_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3;
                    Unity_Lerp_float4(_Property_cd262e3649c94d36ac1a6035934c82ba_Out_0, _Property_c08d4525fbf641d78eb168f9e6c77374_Out_0, (_Clamp_07516fbacac148a2ab07ae8f0615108e_Out_3.xxxx), _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_5482a63064fe4dc986c10d26e2a866c9_Out_0 = _normalTiling;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Property_b18edaa63f6640f1abc5e1c084fa03d7_Out_0 = _mainNormalDirection;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_26a9c6abd5cb40b5bea80cc2e337259f_Out_2;
                    Unity_Multiply_float((IN.TimeParameters.x.xxx), _Property_b18edaa63f6640f1abc5e1c084fa03d7_Out_0, _Multiply_26a9c6abd5cb40b5bea80cc2e337259f_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Vector1_cce353cff4d443cbad9f0028192af8a7_Out_0 = 5;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Divide_436ce3df6a4b4ab384b5f9e6fde7cbff_Out_2;
                    Unity_Divide_float3(_Multiply_26a9c6abd5cb40b5bea80cc2e337259f_Out_2, (_Vector1_cce353cff4d443cbad9f0028192af8a7_Out_0.xxx), _Divide_436ce3df6a4b4ab384b5f9e6fde7cbff_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_a100da2d1db545d3bdd6a98d6c3338b4_Out_0 = _normalSpeed;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_52a0ffd9cfff4dbca39fd96e162d6f38_Out_2;
                    Unity_Multiply_float(_Divide_436ce3df6a4b4ab384b5f9e6fde7cbff_Out_2, (_Property_a100da2d1db545d3bdd6a98d6c3338b4_Out_0.xxx), _Multiply_52a0ffd9cfff4dbca39fd96e162d6f38_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float2 _TilingAndOffset_d7789ee50db3482f9d54ada635414804_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, (_Property_5482a63064fe4dc986c10d26e2a866c9_Out_0.xx), (_Multiply_52a0ffd9cfff4dbca39fd96e162d6f38_Out_2.xy), _TilingAndOffset_d7789ee50db3482f9d54ada635414804_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_RGBA_0 = SAMPLE_TEXTURE2D(_mainNormal, sampler_mainNormal, _TilingAndOffset_d7789ee50db3482f9d54ada635414804_Out_3);
                    _SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_RGBA_0);
                    float _SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_R_4 = _SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_RGBA_0.r;
                    float _SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_G_5 = _SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_RGBA_0.g;
                    float _SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_B_6 = _SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_RGBA_0.b;
                    float _SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_A_7 = _SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_RGBA_0.a;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Property_dbda2894373e42498a86446296d428f0_Out_0 = _secondNormalDirection;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_69c904868d6240009395971af991ea70_Out_2;
                    Unity_Multiply_float((IN.TimeParameters.x.xxx), _Property_dbda2894373e42498a86446296d428f0_Out_0, _Multiply_69c904868d6240009395971af991ea70_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Vector1_86da2039a4f840cba31ad8417eedfdbe_Out_0 = 5;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Divide_7e931fd752a14839ac903c8c1f23fa8b_Out_2;
                    Unity_Divide_float3(_Multiply_69c904868d6240009395971af991ea70_Out_2, (_Vector1_86da2039a4f840cba31ad8417eedfdbe_Out_0.xxx), _Divide_7e931fd752a14839ac903c8c1f23fa8b_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_9b564bc582834a84b02772947489b2ee_Out_0 = _normalSpeed;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_a0a0b6832fcd46c0badaac4e7758d9af_Out_2;
                    Unity_Multiply_float(_Divide_7e931fd752a14839ac903c8c1f23fa8b_Out_2, (_Property_9b564bc582834a84b02772947489b2ee_Out_0.xxx), _Multiply_a0a0b6832fcd46c0badaac4e7758d9af_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float2 _TilingAndOffset_248c7474eeba4e7b9f1353cc429027df_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, (_Property_5482a63064fe4dc986c10d26e2a866c9_Out_0.xx), (_Multiply_a0a0b6832fcd46c0badaac4e7758d9af_Out_2.xy), _TilingAndOffset_248c7474eeba4e7b9f1353cc429027df_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _SampleTexture2D_19fa380f103d42a49d00ac60250e471c_RGBA_0 = SAMPLE_TEXTURE2D(_secondNormal, sampler_secondNormal, _TilingAndOffset_248c7474eeba4e7b9f1353cc429027df_Out_3);
                    _SampleTexture2D_19fa380f103d42a49d00ac60250e471c_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_19fa380f103d42a49d00ac60250e471c_RGBA_0);
                    float _SampleTexture2D_19fa380f103d42a49d00ac60250e471c_R_4 = _SampleTexture2D_19fa380f103d42a49d00ac60250e471c_RGBA_0.r;
                    float _SampleTexture2D_19fa380f103d42a49d00ac60250e471c_G_5 = _SampleTexture2D_19fa380f103d42a49d00ac60250e471c_RGBA_0.g;
                    float _SampleTexture2D_19fa380f103d42a49d00ac60250e471c_B_6 = _SampleTexture2D_19fa380f103d42a49d00ac60250e471c_RGBA_0.b;
                    float _SampleTexture2D_19fa380f103d42a49d00ac60250e471c_A_7 = _SampleTexture2D_19fa380f103d42a49d00ac60250e471c_RGBA_0.a;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Add_848875f285c84daf9d7cce6829511404_Out_2;
                    Unity_Add_float4(_SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_RGBA_0, _SampleTexture2D_19fa380f103d42a49d00ac60250e471c_RGBA_0, _Add_848875f285c84daf9d7cce6829511404_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_8a702d79c0774b35aa6e24f8f95f098e_Out_0 = _normalStrength;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _NormalStrength_51ceaf799ace4a3abbc7030d015375d7_Out_2;
                    Unity_NormalStrength_float((_Add_848875f285c84daf9d7cce6829511404_Out_2.xyz), _Property_8a702d79c0774b35aa6e24f8f95f098e_Out_0, _NormalStrength_51ceaf799ace4a3abbc7030d015375d7_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_9dbd6cc5b1314dceb76f85fbbb09dc7d_Out_0 = _smoothness;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Split_5dc8f38583ee40c19b6f09138a95e012_R_1 = _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3[0];
                    float _Split_5dc8f38583ee40c19b6f09138a95e012_G_2 = _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3[1];
                    float _Split_5dc8f38583ee40c19b6f09138a95e012_B_3 = _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3[2];
                    float _Split_5dc8f38583ee40c19b6f09138a95e012_A_4 = _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3[3];
                    #endif
                    surface.BaseColor = (_Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3.xyz);
                    surface.NormalTS = _NormalStrength_51ceaf799ace4a3abbc7030d015375d7_Out_2;
                    surface.Emission = float3(0, 0, 0);
                    surface.Metallic = 0;
                    surface.Smoothness = _Property_9dbd6cc5b1314dceb76f85fbbb09dc7d_Out_0;
                    surface.Occlusion = 1;
                    surface.Alpha = _Split_5dc8f38583ee40c19b6f09138a95e012_A_4;
                    surface.AlphaClipThreshold = 0;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ObjectSpaceNormal =           input.normalOS;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ObjectSpaceTangent =          input.tangentOS;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ObjectSpacePosition =         input.positionOS;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpacePosition =          TransformObjectToWorld(input.positionOS);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.uv0 =                         input.uv0;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.TimeParameters =              _TimeParameters.xyz;
                #endif
                
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                #endif
                
                
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpacePosition =          input.positionWS;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.uv0 =                         input.texCoord0;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.TimeParameters =              _TimeParameters.xyz; // This is mainly for LW as HD overwrite this value
                #endif
                
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
                #else
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                #endif
                #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                
                    return output;
                }
                
    
                // --------------------------------------------------
                // Main
    
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBRForwardPass.hlsl"
    
                ENDHLSL
            }
            Pass
            {
                Name "Universal GBuffer"
                Tags
                {
                    "LightMode" = "UniversalGBuffer"
                }
    
                // Render State
                Cull Back
                Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
                ZTest LEqual
                ZWrite Off
    
                // Debug
                // <None>
    
                // --------------------------------------------------
                // Pass
    
                HLSLPROGRAM
    
                // Pragmas
                #pragma target 4.5
                #pragma exclude_renderers d3d11_9x gles
                #pragma multi_compile_instancing
                #pragma multi_compile_fog
                #pragma multi_compile _ DOTS_INSTANCING_ON
                #pragma vertex vert
                #pragma fragment frag
    
                // DotsInstancingOptions: <None>
                // HybridV1InjectedBuiltinProperties: <None>
    
                // Keywords
                #pragma multi_compile _ LIGHTMAP_ON
                #pragma multi_compile _ DIRLIGHTMAP_COMBINED
                #pragma multi_compile _ _MAIN_LIGHT_SHADOWS
                #pragma multi_compile _ _MAIN_LIGHT_SHADOWS_CASCADE
                #pragma multi_compile _ _SHADOWS_SOFT
                #pragma multi_compile _ _MIXED_LIGHTING_SUBTRACTIVE
                #pragma multi_compile _ _GBUFFER_NORMALS_OCT
                #pragma shader_feature_local _ BOOLEAN_2D5E488208064DEDBE97E09FA59744E9_ON
                
                #if defined(BOOLEAN_2D5E488208064DEDBE97E09FA59744E9_ON)
                    #define KEYWORD_PERMUTATION_0
                #else
                    #define KEYWORD_PERMUTATION_1
                #endif
                
    
                // Defines
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define _SURFACE_TYPE_TRANSPARENT 1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define _AlphaClip 1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define _NORMALMAP 1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define _NORMAL_DROPOFF_TS 1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define ATTRIBUTES_NEED_NORMAL
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define ATTRIBUTES_NEED_TANGENT
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define ATTRIBUTES_NEED_TEXCOORD0
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define ATTRIBUTES_NEED_TEXCOORD1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define VARYINGS_NEED_POSITION_WS
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define VARYINGS_NEED_NORMAL_WS
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define VARYINGS_NEED_TANGENT_WS
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define VARYINGS_NEED_TEXCOORD0
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define VARYINGS_NEED_VIEWDIRECTION_WS
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
            #endif
    
                #define FEATURES_GRAPH_VERTEX
                /* WARNING: $splice Could not find named fragment 'PassInstancing' */
                #define SHADERPASS SHADERPASS_GBUFFER
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #define REQUIRE_DEPTH_TEXTURE
                #endif
                /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
    
                // Includes
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
    
                // --------------------------------------------------
                // Structs and Packing
    
                struct Attributes
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 positionOS : POSITION;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 normalOS : NORMAL;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 tangentOS : TANGENT;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 uv0 : TEXCOORD0;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 uv1 : TEXCOORD1;
                    #endif
                    #if UNITY_ANY_INSTANCING_ENABLED
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint instanceID : INSTANCEID_SEMANTIC;
                    #endif
                    #endif
                };
                struct Varyings
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 positionCS : SV_POSITION;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 positionWS;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 normalWS;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 tangentWS;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 texCoord0;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 viewDirectionWS;
                    #endif
                    #if defined(LIGHTMAP_ON)
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float2 lightmapUV;
                    #endif
                    #endif
                    #if !defined(LIGHTMAP_ON)
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 sh;
                    #endif
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 fogFactorAndVertexLight;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 shadowCoord;
                    #endif
                    #if UNITY_ANY_INSTANCING_ENABLED
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                    #endif
                };
                struct SurfaceDescriptionInputs
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 TangentSpaceNormal;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpacePosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 ScreenPosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 uv0;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 TimeParameters;
                    #endif
                };
                struct VertexDescriptionInputs
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 ObjectSpaceNormal;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpaceNormal;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 ObjectSpaceTangent;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpaceTangent;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 ObjectSpaceBiTangent;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpaceBiTangent;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 ObjectSpacePosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpacePosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 uv0;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 TimeParameters;
                    #endif
                };
                struct PackedVaryings
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 positionCS : SV_POSITION;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 interp0 : TEXCOORD0;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 interp1 : TEXCOORD1;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 interp2 : TEXCOORD2;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 interp3 : TEXCOORD3;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 interp4 : TEXCOORD4;
                    #endif
                    #if defined(LIGHTMAP_ON)
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float2 interp5 : TEXCOORD5;
                    #endif
                    #endif
                    #if !defined(LIGHTMAP_ON)
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 interp6 : TEXCOORD6;
                    #endif
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 interp7 : TEXCOORD7;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 interp8 : TEXCOORD8;
                    #endif
                    #if UNITY_ANY_INSTANCING_ENABLED
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                    #endif
                };
    
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                PackedVaryings PackVaryings (Varyings input)
                    {
                        PackedVaryings output;
                        output.positionCS = input.positionCS;
                        output.interp0.xyz =  input.positionWS;
                        output.interp1.xyz =  input.normalWS;
                        output.interp2.xyzw =  input.tangentWS;
                        output.interp3.xyzw =  input.texCoord0;
                        output.interp4.xyz =  input.viewDirectionWS;
                        #if defined(LIGHTMAP_ON)
                        output.interp5.xy =  input.lightmapUV;
                        #endif
                        #if !defined(LIGHTMAP_ON)
                        output.interp6.xyz =  input.sh;
                        #endif
                        output.interp7.xyzw =  input.fogFactorAndVertexLight;
                        output.interp8.xyzw =  input.shadowCoord;
                        #if UNITY_ANY_INSTANCING_ENABLED
                        output.instanceID = input.instanceID;
                        #endif
                        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                        #endif
                        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                        #endif
                        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                        output.cullFace = input.cullFace;
                        #endif
                        return output;
                    }
                    Varyings UnpackVaryings (PackedVaryings input)
                    {
                        Varyings output;
                        output.positionCS = input.positionCS;
                        output.positionWS = input.interp0.xyz;
                        output.normalWS = input.interp1.xyz;
                        output.tangentWS = input.interp2.xyzw;
                        output.texCoord0 = input.interp3.xyzw;
                        output.viewDirectionWS = input.interp4.xyz;
                        #if defined(LIGHTMAP_ON)
                        output.lightmapUV = input.interp5.xy;
                        #endif
                        #if !defined(LIGHTMAP_ON)
                        output.sh = input.interp6.xyz;
                        #endif
                        output.fogFactorAndVertexLight = input.interp7.xyzw;
                        output.shadowCoord = input.interp8.xyzw;
                        #if UNITY_ANY_INSTANCING_ENABLED
                        output.instanceID = input.instanceID;
                        #endif
                        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                        #endif
                        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                        #endif
                        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                        output.cullFace = input.cullFace;
                        #endif
                        return output;
                    }
                #endif
    
                // --------------------------------------------------
                // Graph
    
                // Graph Properties
                CBUFFER_START(UnityPerMaterial)
                float _depth;
                float _depthStrength;
                float4 _deepWaterColor;
                float4 _shallowWaterColor;
                float _smoothness;
                float _normalStrength;
                float _normalTiling;
                float _normalSpeed;
                float3 _mainNormalDirection;
                float3 _secondNormalDirection;
                float _amplitude;
                float _waves;
                float _wavesSpeed;
                CBUFFER_END
                TEXTURE2D(_mainNormal); SAMPLER(sampler_mainNormal); float4 _mainNormal_TexelSize;
                TEXTURE2D(_secondNormal); SAMPLER(sampler_secondNormal); float4 _secondNormal_TexelSize;
                SAMPLER(_SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_19fa380f103d42a49d00ac60250e471c_Sampler_3_Linear_Repeat);
    
                // Graph Functions
                
                void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A / B;
                }
                
                void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                {
                    Out = UV * Tiling + Offset;
                }
                
                
                float2 Unity_GradientNoise_Dir_float(float2 p)
                {
                    // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
                    p = p % 289;
                    // need full precision, otherwise half overflows when p > 1
                    float x = float(34 * p.x + 1) * p.x % 289 + p.y;
                    x = (34 * x + 1) * x % 289;
                    x = frac(x / 41) * 2 - 1;
                    return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
                }
                
                void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
                { 
                    float2 p = UV * Scale;
                    float2 ip = floor(p);
                    float2 fp = frac(p);
                    float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
                    float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
                    float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
                    float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
                    fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
                    Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
                }
                
                void Unity_Add_float(float A, float B, out float Out)
                {
                    Out = A + B;
                }
                
                void Unity_Divide_float(float A, float B, out float Out)
                {
                    Out = A / B;
                }
                
                void Unity_Subtract_float(float A, float B, out float Out)
                {
                    Out = A - B;
                }
                
                void Unity_Multiply_float(float A, float B, out float Out)
                {
                    Out = A * B;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_SceneDepth_Linear01_float(float4 UV, out float Out)
                {
                    Out = Linear01Depth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
                }
                
                void Unity_Clamp_float(float In, float Min, float Max, out float Out)
                {
                    Out = clamp(In, Min, Max);
                }
                
                void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
                {
                    Out = lerp(A, B, T);
                }
                
                void Unity_Add_float4(float4 A, float4 B, out float4 Out)
                {
                    Out = A + B;
                }
                
                void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
                {
                    Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
                }
    
                // Graph Vertex
                struct VertexDescription
                {
                    float3 Position;
                    float3 Normal;
                    float3 Tangent;
                };
                
                VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                {
                    VertexDescription description = (VertexDescription)0;
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Split_ff0fd34a61f44fd7ae2f222441749bd9_R_1 = IN.WorldSpacePosition[0];
                    float _Split_ff0fd34a61f44fd7ae2f222441749bd9_G_2 = IN.WorldSpacePosition[1];
                    float _Split_ff0fd34a61f44fd7ae2f222441749bd9_B_3 = IN.WorldSpacePosition[2];
                    float _Split_ff0fd34a61f44fd7ae2f222441749bd9_A_4 = 0;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_f4af681ed89a4a3d8c81333e9f8b562d_Out_0 = _waves;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Property_49ef859bb89c4a8288c9eb1583334fde_Out_0 = _mainNormalDirection;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_992df1e5e71b4479bbb5a25e534d8861_Out_2;
                    Unity_Multiply_float((IN.TimeParameters.x.xxx), _Property_49ef859bb89c4a8288c9eb1583334fde_Out_0, _Multiply_992df1e5e71b4479bbb5a25e534d8861_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Vector1_60e9a38039a843989ca21ba08ba76bd7_Out_0 = 5;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Divide_eb274efe27a64e71ba9baa084548bb6c_Out_2;
                    Unity_Divide_float3(_Multiply_992df1e5e71b4479bbb5a25e534d8861_Out_2, (_Vector1_60e9a38039a843989ca21ba08ba76bd7_Out_0.xxx), _Divide_eb274efe27a64e71ba9baa084548bb6c_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_92f37cd5909d40809e2b672d1636bd54_Out_0 = _wavesSpeed;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_afb804d1277148d7b992f652bb14e3be_Out_2;
                    Unity_Multiply_float(_Divide_eb274efe27a64e71ba9baa084548bb6c_Out_2, (_Property_92f37cd5909d40809e2b672d1636bd54_Out_0.xxx), _Multiply_afb804d1277148d7b992f652bb14e3be_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float2 _TilingAndOffset_05baded2421248cd9222b83233309dcb_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, (_Property_f4af681ed89a4a3d8c81333e9f8b562d_Out_0.xx), (_Multiply_afb804d1277148d7b992f652bb14e3be_Out_2.xy), _TilingAndOffset_05baded2421248cd9222b83233309dcb_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _GradientNoise_5b5f40a249b347c9be3b4afc6d0ed3ad_Out_2;
                    Unity_GradientNoise_float(_TilingAndOffset_05baded2421248cd9222b83233309dcb_Out_3, 10, _GradientNoise_5b5f40a249b347c9be3b4afc6d0ed3ad_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Property_666f9a531b564538acc376057bc6caa9_Out_0 = _secondNormalDirection;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_118898149cbd4850b0807b9467ed73b4_Out_2;
                    Unity_Multiply_float((IN.TimeParameters.x.xxx), _Property_666f9a531b564538acc376057bc6caa9_Out_0, _Multiply_118898149cbd4850b0807b9467ed73b4_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Vector1_ea96af95fe4f4961ad8bfc89f5bc9a03_Out_0 = 5;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Divide_b7c139d64ea9401fbda3a903c9fd1bf6_Out_2;
                    Unity_Divide_float3(_Multiply_118898149cbd4850b0807b9467ed73b4_Out_2, (_Vector1_ea96af95fe4f4961ad8bfc89f5bc9a03_Out_0.xxx), _Divide_b7c139d64ea9401fbda3a903c9fd1bf6_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_6199970682ac4c9c947732b8aa1e32b0_Out_2;
                    Unity_Multiply_float(_Divide_b7c139d64ea9401fbda3a903c9fd1bf6_Out_2, (_Property_92f37cd5909d40809e2b672d1636bd54_Out_0.xxx), _Multiply_6199970682ac4c9c947732b8aa1e32b0_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float2 _TilingAndOffset_2d869c568f8c4bd1935e9e1a5d383ff4_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, (_Property_f4af681ed89a4a3d8c81333e9f8b562d_Out_0.xx), (_Multiply_6199970682ac4c9c947732b8aa1e32b0_Out_2.xy), _TilingAndOffset_2d869c568f8c4bd1935e9e1a5d383ff4_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _GradientNoise_7d50ab18cca7435cbe45ace0410a84c7_Out_2;
                    Unity_GradientNoise_float(_TilingAndOffset_2d869c568f8c4bd1935e9e1a5d383ff4_Out_3, 10, _GradientNoise_7d50ab18cca7435cbe45ace0410a84c7_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Add_3ab7d42c644a4df381d663f07b7ab1e9_Out_2;
                    Unity_Add_float(_GradientNoise_5b5f40a249b347c9be3b4afc6d0ed3ad_Out_2, _GradientNoise_7d50ab18cca7435cbe45ace0410a84c7_Out_2, _Add_3ab7d42c644a4df381d663f07b7ab1e9_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Divide_cefb6bacdd4e476ea8103edefe43f584_Out_2;
                    Unity_Divide_float(_Add_3ab7d42c644a4df381d663f07b7ab1e9_Out_2, 2, _Divide_cefb6bacdd4e476ea8103edefe43f584_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Subtract_4da7b6862bcc45eca57cbd26b806eaf0_Out_2;
                    Unity_Subtract_float(_Divide_cefb6bacdd4e476ea8103edefe43f584_Out_2, 0.61, _Subtract_4da7b6862bcc45eca57cbd26b806eaf0_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_ce933f1cb0934b47a86069374aea82d8_Out_0 = _amplitude;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Multiply_fc80491e653843f7b95b7d963584d21d_Out_2;
                    Unity_Multiply_float(_Subtract_4da7b6862bcc45eca57cbd26b806eaf0_Out_2, _Property_ce933f1cb0934b47a86069374aea82d8_Out_0, _Multiply_fc80491e653843f7b95b7d963584d21d_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Combine_4394e5327dea4ebda9c6b40c020e0721_RGBA_4;
                    float3 _Combine_4394e5327dea4ebda9c6b40c020e0721_RGB_5;
                    float2 _Combine_4394e5327dea4ebda9c6b40c020e0721_RG_6;
                    Unity_Combine_float(_Split_ff0fd34a61f44fd7ae2f222441749bd9_R_1, _Multiply_fc80491e653843f7b95b7d963584d21d_Out_2, _Split_ff0fd34a61f44fd7ae2f222441749bd9_B_3, 0, _Combine_4394e5327dea4ebda9c6b40c020e0721_RGBA_4, _Combine_4394e5327dea4ebda9c6b40c020e0721_RGB_5, _Combine_4394e5327dea4ebda9c6b40c020e0721_RG_6);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Transform_5f6d055972de4e69871e05659dc0cf87_Out_1 = TransformWorldToObject(_Combine_4394e5327dea4ebda9c6b40c020e0721_RGB_5.xyz);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Combine_989bd6296fa44c898dce3b24fde18c9d_RGBA_4;
                    float3 _Combine_989bd6296fa44c898dce3b24fde18c9d_RGB_5;
                    float2 _Combine_989bd6296fa44c898dce3b24fde18c9d_RG_6;
                    Unity_Combine_float(_Split_ff0fd34a61f44fd7ae2f222441749bd9_R_1, _Split_ff0fd34a61f44fd7ae2f222441749bd9_G_2, _Split_ff0fd34a61f44fd7ae2f222441749bd9_B_3, 0, _Combine_989bd6296fa44c898dce3b24fde18c9d_RGBA_4, _Combine_989bd6296fa44c898dce3b24fde18c9d_RGB_5, _Combine_989bd6296fa44c898dce3b24fde18c9d_RG_6);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    #if defined(BOOLEAN_2D5E488208064DEDBE97E09FA59744E9_ON)
                    float3 _Waving_e9c7407f61464da88e74e85183ca2065_Out_0 = _Transform_5f6d055972de4e69871e05659dc0cf87_Out_1;
                    #else
                    float3 _Waving_e9c7407f61464da88e74e85183ca2065_Out_0 = _Combine_989bd6296fa44c898dce3b24fde18c9d_RGB_5;
                    #endif
                    #endif
                    description.Position = _Waving_e9c7407f61464da88e74e85183ca2065_Out_0;
                    description.Normal = IN.ObjectSpaceNormal;
                    description.Tangent = IN.ObjectSpaceTangent;
                    return description;
                }
    
                // Graph Pixel
                struct SurfaceDescription
                {
                    float3 BaseColor;
                    float3 NormalTS;
                    float3 Emission;
                    float Metallic;
                    float Smoothness;
                    float Occlusion;
                    float Alpha;
                    float AlphaClipThreshold;
                };
                
                SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                {
                    SurfaceDescription surface = (SurfaceDescription)0;
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Property_cd262e3649c94d36ac1a6035934c82ba_Out_0 = _shallowWaterColor;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Property_c08d4525fbf641d78eb168f9e6c77374_Out_0 = _deepWaterColor;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _SceneDepth_ff2814420f634b6c9006b17db1b0db86_Out_1;
                    Unity_SceneDepth_Linear01_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_ff2814420f634b6c9006b17db1b0db86_Out_1);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Multiply_7fe029570de94c259af598c01f1e9fc7_Out_2;
                    Unity_Multiply_float(_SceneDepth_ff2814420f634b6c9006b17db1b0db86_Out_1, _ProjectionParams.z, _Multiply_7fe029570de94c259af598c01f1e9fc7_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_69b3cbbc42e345ba9fcd9de510b5e2d7_Out_0 = _depth;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0 = IN.ScreenPosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Split_4da6c10dd6e44537a1e2021901925b9e_R_1 = _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0[0];
                    float _Split_4da6c10dd6e44537a1e2021901925b9e_G_2 = _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0[1];
                    float _Split_4da6c10dd6e44537a1e2021901925b9e_B_3 = _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0[2];
                    float _Split_4da6c10dd6e44537a1e2021901925b9e_A_4 = _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0[3];
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Add_5516261d5322477cbf6c851a3128394f_Out_2;
                    Unity_Add_float(_Property_69b3cbbc42e345ba9fcd9de510b5e2d7_Out_0, _Split_4da6c10dd6e44537a1e2021901925b9e_A_4, _Add_5516261d5322477cbf6c851a3128394f_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Subtract_f153dba44eeb4c808ffd45ea4a4f742e_Out_2;
                    Unity_Subtract_float(_Multiply_7fe029570de94c259af598c01f1e9fc7_Out_2, _Add_5516261d5322477cbf6c851a3128394f_Out_2, _Subtract_f153dba44eeb4c808ffd45ea4a4f742e_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_3b327dff25184e83be825e3db1854a26_Out_0 = _depthStrength;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Multiply_bcf5cd29cecf4b4f97083346027d340a_Out_2;
                    Unity_Multiply_float(_Subtract_f153dba44eeb4c808ffd45ea4a4f742e_Out_2, _Property_3b327dff25184e83be825e3db1854a26_Out_0, _Multiply_bcf5cd29cecf4b4f97083346027d340a_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Clamp_07516fbacac148a2ab07ae8f0615108e_Out_3;
                    Unity_Clamp_float(_Multiply_bcf5cd29cecf4b4f97083346027d340a_Out_2, 0, 1, _Clamp_07516fbacac148a2ab07ae8f0615108e_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3;
                    Unity_Lerp_float4(_Property_cd262e3649c94d36ac1a6035934c82ba_Out_0, _Property_c08d4525fbf641d78eb168f9e6c77374_Out_0, (_Clamp_07516fbacac148a2ab07ae8f0615108e_Out_3.xxxx), _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_5482a63064fe4dc986c10d26e2a866c9_Out_0 = _normalTiling;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Property_b18edaa63f6640f1abc5e1c084fa03d7_Out_0 = _mainNormalDirection;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_26a9c6abd5cb40b5bea80cc2e337259f_Out_2;
                    Unity_Multiply_float((IN.TimeParameters.x.xxx), _Property_b18edaa63f6640f1abc5e1c084fa03d7_Out_0, _Multiply_26a9c6abd5cb40b5bea80cc2e337259f_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Vector1_cce353cff4d443cbad9f0028192af8a7_Out_0 = 5;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Divide_436ce3df6a4b4ab384b5f9e6fde7cbff_Out_2;
                    Unity_Divide_float3(_Multiply_26a9c6abd5cb40b5bea80cc2e337259f_Out_2, (_Vector1_cce353cff4d443cbad9f0028192af8a7_Out_0.xxx), _Divide_436ce3df6a4b4ab384b5f9e6fde7cbff_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_a100da2d1db545d3bdd6a98d6c3338b4_Out_0 = _normalSpeed;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_52a0ffd9cfff4dbca39fd96e162d6f38_Out_2;
                    Unity_Multiply_float(_Divide_436ce3df6a4b4ab384b5f9e6fde7cbff_Out_2, (_Property_a100da2d1db545d3bdd6a98d6c3338b4_Out_0.xxx), _Multiply_52a0ffd9cfff4dbca39fd96e162d6f38_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float2 _TilingAndOffset_d7789ee50db3482f9d54ada635414804_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, (_Property_5482a63064fe4dc986c10d26e2a866c9_Out_0.xx), (_Multiply_52a0ffd9cfff4dbca39fd96e162d6f38_Out_2.xy), _TilingAndOffset_d7789ee50db3482f9d54ada635414804_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_RGBA_0 = SAMPLE_TEXTURE2D(_mainNormal, sampler_mainNormal, _TilingAndOffset_d7789ee50db3482f9d54ada635414804_Out_3);
                    _SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_RGBA_0);
                    float _SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_R_4 = _SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_RGBA_0.r;
                    float _SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_G_5 = _SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_RGBA_0.g;
                    float _SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_B_6 = _SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_RGBA_0.b;
                    float _SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_A_7 = _SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_RGBA_0.a;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Property_dbda2894373e42498a86446296d428f0_Out_0 = _secondNormalDirection;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_69c904868d6240009395971af991ea70_Out_2;
                    Unity_Multiply_float((IN.TimeParameters.x.xxx), _Property_dbda2894373e42498a86446296d428f0_Out_0, _Multiply_69c904868d6240009395971af991ea70_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Vector1_86da2039a4f840cba31ad8417eedfdbe_Out_0 = 5;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Divide_7e931fd752a14839ac903c8c1f23fa8b_Out_2;
                    Unity_Divide_float3(_Multiply_69c904868d6240009395971af991ea70_Out_2, (_Vector1_86da2039a4f840cba31ad8417eedfdbe_Out_0.xxx), _Divide_7e931fd752a14839ac903c8c1f23fa8b_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_9b564bc582834a84b02772947489b2ee_Out_0 = _normalSpeed;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_a0a0b6832fcd46c0badaac4e7758d9af_Out_2;
                    Unity_Multiply_float(_Divide_7e931fd752a14839ac903c8c1f23fa8b_Out_2, (_Property_9b564bc582834a84b02772947489b2ee_Out_0.xxx), _Multiply_a0a0b6832fcd46c0badaac4e7758d9af_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float2 _TilingAndOffset_248c7474eeba4e7b9f1353cc429027df_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, (_Property_5482a63064fe4dc986c10d26e2a866c9_Out_0.xx), (_Multiply_a0a0b6832fcd46c0badaac4e7758d9af_Out_2.xy), _TilingAndOffset_248c7474eeba4e7b9f1353cc429027df_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _SampleTexture2D_19fa380f103d42a49d00ac60250e471c_RGBA_0 = SAMPLE_TEXTURE2D(_secondNormal, sampler_secondNormal, _TilingAndOffset_248c7474eeba4e7b9f1353cc429027df_Out_3);
                    _SampleTexture2D_19fa380f103d42a49d00ac60250e471c_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_19fa380f103d42a49d00ac60250e471c_RGBA_0);
                    float _SampleTexture2D_19fa380f103d42a49d00ac60250e471c_R_4 = _SampleTexture2D_19fa380f103d42a49d00ac60250e471c_RGBA_0.r;
                    float _SampleTexture2D_19fa380f103d42a49d00ac60250e471c_G_5 = _SampleTexture2D_19fa380f103d42a49d00ac60250e471c_RGBA_0.g;
                    float _SampleTexture2D_19fa380f103d42a49d00ac60250e471c_B_6 = _SampleTexture2D_19fa380f103d42a49d00ac60250e471c_RGBA_0.b;
                    float _SampleTexture2D_19fa380f103d42a49d00ac60250e471c_A_7 = _SampleTexture2D_19fa380f103d42a49d00ac60250e471c_RGBA_0.a;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Add_848875f285c84daf9d7cce6829511404_Out_2;
                    Unity_Add_float4(_SampleTexture2D_a98b1f8156a940ec8f7839858bc7353c_RGBA_0, _SampleTexture2D_19fa380f103d42a49d00ac60250e471c_RGBA_0, _Add_848875f285c84daf9d7cce6829511404_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_8a702d79c0774b35aa6e24f8f95f098e_Out_0 = _normalStrength;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _NormalStrength_51ceaf799ace4a3abbc7030d015375d7_Out_2;
                    Unity_NormalStrength_float((_Add_848875f285c84daf9d7cce6829511404_Out_2.xyz), _Property_8a702d79c0774b35aa6e24f8f95f098e_Out_0, _NormalStrength_51ceaf799ace4a3abbc7030d015375d7_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_9dbd6cc5b1314dceb76f85fbbb09dc7d_Out_0 = _smoothness;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Split_5dc8f38583ee40c19b6f09138a95e012_R_1 = _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3[0];
                    float _Split_5dc8f38583ee40c19b6f09138a95e012_G_2 = _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3[1];
                    float _Split_5dc8f38583ee40c19b6f09138a95e012_B_3 = _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3[2];
                    float _Split_5dc8f38583ee40c19b6f09138a95e012_A_4 = _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3[3];
                    #endif
                    surface.BaseColor = (_Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3.xyz);
                    surface.NormalTS = _NormalStrength_51ceaf799ace4a3abbc7030d015375d7_Out_2;
                    surface.Emission = float3(0, 0, 0);
                    surface.Metallic = 0;
                    surface.Smoothness = _Property_9dbd6cc5b1314dceb76f85fbbb09dc7d_Out_0;
                    surface.Occlusion = 1;
                    surface.Alpha = _Split_5dc8f38583ee40c19b6f09138a95e012_A_4;
                    surface.AlphaClipThreshold = 0;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ObjectSpaceNormal =           input.normalOS;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ObjectSpaceTangent =          input.tangentOS;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ObjectSpacePosition =         input.positionOS;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpacePosition =          TransformObjectToWorld(input.positionOS);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.uv0 =                         input.uv0;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.TimeParameters =              _TimeParameters.xyz;
                #endif
                
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                #endif
                
                
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpacePosition =          input.positionWS;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.uv0 =                         input.texCoord0;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.TimeParameters =              _TimeParameters.xyz; // This is mainly for LW as HD overwrite this value
                #endif
                
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
                #else
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                #endif
                #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                
                    return output;
                }
                
    
                // --------------------------------------------------
                // Main
    
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/UnityGBuffer.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBRGBufferPass.hlsl"
    
                ENDHLSL
            }
            Pass
            {
                Name "ShadowCaster"
                Tags
                {
                    "LightMode" = "ShadowCaster"
                }
    
                // Render State
                Cull Back
                Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
                ZTest LEqual
                ZWrite On
    
                // Debug
                // <None>
    
                // --------------------------------------------------
                // Pass
    
                HLSLPROGRAM
    
                // Pragmas
                #pragma target 4.5
                #pragma exclude_renderers d3d11_9x gles
                #pragma multi_compile_instancing
                #pragma multi_compile _ DOTS_INSTANCING_ON
                #pragma vertex vert
                #pragma fragment frag
    
                // DotsInstancingOptions: <None>
                // HybridV1InjectedBuiltinProperties: <None>
    
                // Keywords
                // PassKeywords: <None>
                #pragma shader_feature_local _ BOOLEAN_2D5E488208064DEDBE97E09FA59744E9_ON
                
                #if defined(BOOLEAN_2D5E488208064DEDBE97E09FA59744E9_ON)
                    #define KEYWORD_PERMUTATION_0
                #else
                    #define KEYWORD_PERMUTATION_1
                #endif
                
    
                // Defines
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define _SURFACE_TYPE_TRANSPARENT 1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define _AlphaClip 1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define _NORMALMAP 1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define _NORMAL_DROPOFF_TS 1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define ATTRIBUTES_NEED_NORMAL
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define ATTRIBUTES_NEED_TANGENT
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define ATTRIBUTES_NEED_TEXCOORD0
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define VARYINGS_NEED_POSITION_WS
            #endif
    
                #define FEATURES_GRAPH_VERTEX
                /* WARNING: $splice Could not find named fragment 'PassInstancing' */
                #define SHADERPASS SHADERPASS_SHADOWCASTER
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #define REQUIRE_DEPTH_TEXTURE
                #endif
                /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
    
                // Includes
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
    
                // --------------------------------------------------
                // Structs and Packing
    
                struct Attributes
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 positionOS : POSITION;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 normalOS : NORMAL;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 tangentOS : TANGENT;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 uv0 : TEXCOORD0;
                    #endif
                    #if UNITY_ANY_INSTANCING_ENABLED
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint instanceID : INSTANCEID_SEMANTIC;
                    #endif
                    #endif
                };
                struct Varyings
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 positionCS : SV_POSITION;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 positionWS;
                    #endif
                    #if UNITY_ANY_INSTANCING_ENABLED
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                    #endif
                };
                struct SurfaceDescriptionInputs
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpacePosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 ScreenPosition;
                    #endif
                };
                struct VertexDescriptionInputs
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 ObjectSpaceNormal;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpaceNormal;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 ObjectSpaceTangent;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpaceTangent;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 ObjectSpaceBiTangent;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpaceBiTangent;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 ObjectSpacePosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpacePosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 uv0;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 TimeParameters;
                    #endif
                };
                struct PackedVaryings
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 positionCS : SV_POSITION;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 interp0 : TEXCOORD0;
                    #endif
                    #if UNITY_ANY_INSTANCING_ENABLED
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                    #endif
                };
    
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                PackedVaryings PackVaryings (Varyings input)
                    {
                        PackedVaryings output;
                        output.positionCS = input.positionCS;
                        output.interp0.xyz =  input.positionWS;
                        #if UNITY_ANY_INSTANCING_ENABLED
                        output.instanceID = input.instanceID;
                        #endif
                        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                        #endif
                        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                        #endif
                        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                        output.cullFace = input.cullFace;
                        #endif
                        return output;
                    }
                    Varyings UnpackVaryings (PackedVaryings input)
                    {
                        Varyings output;
                        output.positionCS = input.positionCS;
                        output.positionWS = input.interp0.xyz;
                        #if UNITY_ANY_INSTANCING_ENABLED
                        output.instanceID = input.instanceID;
                        #endif
                        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                        #endif
                        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                        #endif
                        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                        output.cullFace = input.cullFace;
                        #endif
                        return output;
                    }
                #endif
    
                // --------------------------------------------------
                // Graph
    
                // Graph Properties
                CBUFFER_START(UnityPerMaterial)
                float _depth;
                float _depthStrength;
                float4 _deepWaterColor;
                float4 _shallowWaterColor;
                float _smoothness;
                float _normalStrength;
                float _normalTiling;
                float _normalSpeed;
                float3 _mainNormalDirection;
                float3 _secondNormalDirection;
                float _amplitude;
                float _waves;
                float _wavesSpeed;
                CBUFFER_END
                TEXTURE2D(_mainNormal); SAMPLER(sampler_mainNormal); float4 _mainNormal_TexelSize;
                TEXTURE2D(_secondNormal); SAMPLER(sampler_secondNormal); float4 _secondNormal_TexelSize;
    
                // Graph Functions
                
                void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A / B;
                }
                
                void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                {
                    Out = UV * Tiling + Offset;
                }
                
                
                float2 Unity_GradientNoise_Dir_float(float2 p)
                {
                    // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
                    p = p % 289;
                    // need full precision, otherwise half overflows when p > 1
                    float x = float(34 * p.x + 1) * p.x % 289 + p.y;
                    x = (34 * x + 1) * x % 289;
                    x = frac(x / 41) * 2 - 1;
                    return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
                }
                
                void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
                { 
                    float2 p = UV * Scale;
                    float2 ip = floor(p);
                    float2 fp = frac(p);
                    float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
                    float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
                    float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
                    float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
                    fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
                    Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
                }
                
                void Unity_Add_float(float A, float B, out float Out)
                {
                    Out = A + B;
                }
                
                void Unity_Divide_float(float A, float B, out float Out)
                {
                    Out = A / B;
                }
                
                void Unity_Subtract_float(float A, float B, out float Out)
                {
                    Out = A - B;
                }
                
                void Unity_Multiply_float(float A, float B, out float Out)
                {
                    Out = A * B;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_SceneDepth_Linear01_float(float4 UV, out float Out)
                {
                    Out = Linear01Depth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
                }
                
                void Unity_Clamp_float(float In, float Min, float Max, out float Out)
                {
                    Out = clamp(In, Min, Max);
                }
                
                void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
                {
                    Out = lerp(A, B, T);
                }
    
                // Graph Vertex
                struct VertexDescription
                {
                    float3 Position;
                    float3 Normal;
                    float3 Tangent;
                };
                
                VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                {
                    VertexDescription description = (VertexDescription)0;
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Split_ff0fd34a61f44fd7ae2f222441749bd9_R_1 = IN.WorldSpacePosition[0];
                    float _Split_ff0fd34a61f44fd7ae2f222441749bd9_G_2 = IN.WorldSpacePosition[1];
                    float _Split_ff0fd34a61f44fd7ae2f222441749bd9_B_3 = IN.WorldSpacePosition[2];
                    float _Split_ff0fd34a61f44fd7ae2f222441749bd9_A_4 = 0;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_f4af681ed89a4a3d8c81333e9f8b562d_Out_0 = _waves;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Property_49ef859bb89c4a8288c9eb1583334fde_Out_0 = _mainNormalDirection;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_992df1e5e71b4479bbb5a25e534d8861_Out_2;
                    Unity_Multiply_float((IN.TimeParameters.x.xxx), _Property_49ef859bb89c4a8288c9eb1583334fde_Out_0, _Multiply_992df1e5e71b4479bbb5a25e534d8861_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Vector1_60e9a38039a843989ca21ba08ba76bd7_Out_0 = 5;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Divide_eb274efe27a64e71ba9baa084548bb6c_Out_2;
                    Unity_Divide_float3(_Multiply_992df1e5e71b4479bbb5a25e534d8861_Out_2, (_Vector1_60e9a38039a843989ca21ba08ba76bd7_Out_0.xxx), _Divide_eb274efe27a64e71ba9baa084548bb6c_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_92f37cd5909d40809e2b672d1636bd54_Out_0 = _wavesSpeed;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_afb804d1277148d7b992f652bb14e3be_Out_2;
                    Unity_Multiply_float(_Divide_eb274efe27a64e71ba9baa084548bb6c_Out_2, (_Property_92f37cd5909d40809e2b672d1636bd54_Out_0.xxx), _Multiply_afb804d1277148d7b992f652bb14e3be_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float2 _TilingAndOffset_05baded2421248cd9222b83233309dcb_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, (_Property_f4af681ed89a4a3d8c81333e9f8b562d_Out_0.xx), (_Multiply_afb804d1277148d7b992f652bb14e3be_Out_2.xy), _TilingAndOffset_05baded2421248cd9222b83233309dcb_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _GradientNoise_5b5f40a249b347c9be3b4afc6d0ed3ad_Out_2;
                    Unity_GradientNoise_float(_TilingAndOffset_05baded2421248cd9222b83233309dcb_Out_3, 10, _GradientNoise_5b5f40a249b347c9be3b4afc6d0ed3ad_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Property_666f9a531b564538acc376057bc6caa9_Out_0 = _secondNormalDirection;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_118898149cbd4850b0807b9467ed73b4_Out_2;
                    Unity_Multiply_float((IN.TimeParameters.x.xxx), _Property_666f9a531b564538acc376057bc6caa9_Out_0, _Multiply_118898149cbd4850b0807b9467ed73b4_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Vector1_ea96af95fe4f4961ad8bfc89f5bc9a03_Out_0 = 5;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Divide_b7c139d64ea9401fbda3a903c9fd1bf6_Out_2;
                    Unity_Divide_float3(_Multiply_118898149cbd4850b0807b9467ed73b4_Out_2, (_Vector1_ea96af95fe4f4961ad8bfc89f5bc9a03_Out_0.xxx), _Divide_b7c139d64ea9401fbda3a903c9fd1bf6_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_6199970682ac4c9c947732b8aa1e32b0_Out_2;
                    Unity_Multiply_float(_Divide_b7c139d64ea9401fbda3a903c9fd1bf6_Out_2, (_Property_92f37cd5909d40809e2b672d1636bd54_Out_0.xxx), _Multiply_6199970682ac4c9c947732b8aa1e32b0_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float2 _TilingAndOffset_2d869c568f8c4bd1935e9e1a5d383ff4_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, (_Property_f4af681ed89a4a3d8c81333e9f8b562d_Out_0.xx), (_Multiply_6199970682ac4c9c947732b8aa1e32b0_Out_2.xy), _TilingAndOffset_2d869c568f8c4bd1935e9e1a5d383ff4_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _GradientNoise_7d50ab18cca7435cbe45ace0410a84c7_Out_2;
                    Unity_GradientNoise_float(_TilingAndOffset_2d869c568f8c4bd1935e9e1a5d383ff4_Out_3, 10, _GradientNoise_7d50ab18cca7435cbe45ace0410a84c7_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Add_3ab7d42c644a4df381d663f07b7ab1e9_Out_2;
                    Unity_Add_float(_GradientNoise_5b5f40a249b347c9be3b4afc6d0ed3ad_Out_2, _GradientNoise_7d50ab18cca7435cbe45ace0410a84c7_Out_2, _Add_3ab7d42c644a4df381d663f07b7ab1e9_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Divide_cefb6bacdd4e476ea8103edefe43f584_Out_2;
                    Unity_Divide_float(_Add_3ab7d42c644a4df381d663f07b7ab1e9_Out_2, 2, _Divide_cefb6bacdd4e476ea8103edefe43f584_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Subtract_4da7b6862bcc45eca57cbd26b806eaf0_Out_2;
                    Unity_Subtract_float(_Divide_cefb6bacdd4e476ea8103edefe43f584_Out_2, 0.61, _Subtract_4da7b6862bcc45eca57cbd26b806eaf0_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_ce933f1cb0934b47a86069374aea82d8_Out_0 = _amplitude;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Multiply_fc80491e653843f7b95b7d963584d21d_Out_2;
                    Unity_Multiply_float(_Subtract_4da7b6862bcc45eca57cbd26b806eaf0_Out_2, _Property_ce933f1cb0934b47a86069374aea82d8_Out_0, _Multiply_fc80491e653843f7b95b7d963584d21d_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Combine_4394e5327dea4ebda9c6b40c020e0721_RGBA_4;
                    float3 _Combine_4394e5327dea4ebda9c6b40c020e0721_RGB_5;
                    float2 _Combine_4394e5327dea4ebda9c6b40c020e0721_RG_6;
                    Unity_Combine_float(_Split_ff0fd34a61f44fd7ae2f222441749bd9_R_1, _Multiply_fc80491e653843f7b95b7d963584d21d_Out_2, _Split_ff0fd34a61f44fd7ae2f222441749bd9_B_3, 0, _Combine_4394e5327dea4ebda9c6b40c020e0721_RGBA_4, _Combine_4394e5327dea4ebda9c6b40c020e0721_RGB_5, _Combine_4394e5327dea4ebda9c6b40c020e0721_RG_6);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Transform_5f6d055972de4e69871e05659dc0cf87_Out_1 = TransformWorldToObject(_Combine_4394e5327dea4ebda9c6b40c020e0721_RGB_5.xyz);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Combine_989bd6296fa44c898dce3b24fde18c9d_RGBA_4;
                    float3 _Combine_989bd6296fa44c898dce3b24fde18c9d_RGB_5;
                    float2 _Combine_989bd6296fa44c898dce3b24fde18c9d_RG_6;
                    Unity_Combine_float(_Split_ff0fd34a61f44fd7ae2f222441749bd9_R_1, _Split_ff0fd34a61f44fd7ae2f222441749bd9_G_2, _Split_ff0fd34a61f44fd7ae2f222441749bd9_B_3, 0, _Combine_989bd6296fa44c898dce3b24fde18c9d_RGBA_4, _Combine_989bd6296fa44c898dce3b24fde18c9d_RGB_5, _Combine_989bd6296fa44c898dce3b24fde18c9d_RG_6);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    #if defined(BOOLEAN_2D5E488208064DEDBE97E09FA59744E9_ON)
                    float3 _Waving_e9c7407f61464da88e74e85183ca2065_Out_0 = _Transform_5f6d055972de4e69871e05659dc0cf87_Out_1;
                    #else
                    float3 _Waving_e9c7407f61464da88e74e85183ca2065_Out_0 = _Combine_989bd6296fa44c898dce3b24fde18c9d_RGB_5;
                    #endif
                    #endif
                    description.Position = _Waving_e9c7407f61464da88e74e85183ca2065_Out_0;
                    description.Normal = IN.ObjectSpaceNormal;
                    description.Tangent = IN.ObjectSpaceTangent;
                    return description;
                }
    
                // Graph Pixel
                struct SurfaceDescription
                {
                    float Alpha;
                    float AlphaClipThreshold;
                };
                
                SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                {
                    SurfaceDescription surface = (SurfaceDescription)0;
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Property_cd262e3649c94d36ac1a6035934c82ba_Out_0 = _shallowWaterColor;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Property_c08d4525fbf641d78eb168f9e6c77374_Out_0 = _deepWaterColor;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _SceneDepth_ff2814420f634b6c9006b17db1b0db86_Out_1;
                    Unity_SceneDepth_Linear01_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_ff2814420f634b6c9006b17db1b0db86_Out_1);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Multiply_7fe029570de94c259af598c01f1e9fc7_Out_2;
                    Unity_Multiply_float(_SceneDepth_ff2814420f634b6c9006b17db1b0db86_Out_1, _ProjectionParams.z, _Multiply_7fe029570de94c259af598c01f1e9fc7_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_69b3cbbc42e345ba9fcd9de510b5e2d7_Out_0 = _depth;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0 = IN.ScreenPosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Split_4da6c10dd6e44537a1e2021901925b9e_R_1 = _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0[0];
                    float _Split_4da6c10dd6e44537a1e2021901925b9e_G_2 = _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0[1];
                    float _Split_4da6c10dd6e44537a1e2021901925b9e_B_3 = _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0[2];
                    float _Split_4da6c10dd6e44537a1e2021901925b9e_A_4 = _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0[3];
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Add_5516261d5322477cbf6c851a3128394f_Out_2;
                    Unity_Add_float(_Property_69b3cbbc42e345ba9fcd9de510b5e2d7_Out_0, _Split_4da6c10dd6e44537a1e2021901925b9e_A_4, _Add_5516261d5322477cbf6c851a3128394f_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Subtract_f153dba44eeb4c808ffd45ea4a4f742e_Out_2;
                    Unity_Subtract_float(_Multiply_7fe029570de94c259af598c01f1e9fc7_Out_2, _Add_5516261d5322477cbf6c851a3128394f_Out_2, _Subtract_f153dba44eeb4c808ffd45ea4a4f742e_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_3b327dff25184e83be825e3db1854a26_Out_0 = _depthStrength;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Multiply_bcf5cd29cecf4b4f97083346027d340a_Out_2;
                    Unity_Multiply_float(_Subtract_f153dba44eeb4c808ffd45ea4a4f742e_Out_2, _Property_3b327dff25184e83be825e3db1854a26_Out_0, _Multiply_bcf5cd29cecf4b4f97083346027d340a_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Clamp_07516fbacac148a2ab07ae8f0615108e_Out_3;
                    Unity_Clamp_float(_Multiply_bcf5cd29cecf4b4f97083346027d340a_Out_2, 0, 1, _Clamp_07516fbacac148a2ab07ae8f0615108e_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3;
                    Unity_Lerp_float4(_Property_cd262e3649c94d36ac1a6035934c82ba_Out_0, _Property_c08d4525fbf641d78eb168f9e6c77374_Out_0, (_Clamp_07516fbacac148a2ab07ae8f0615108e_Out_3.xxxx), _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Split_5dc8f38583ee40c19b6f09138a95e012_R_1 = _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3[0];
                    float _Split_5dc8f38583ee40c19b6f09138a95e012_G_2 = _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3[1];
                    float _Split_5dc8f38583ee40c19b6f09138a95e012_B_3 = _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3[2];
                    float _Split_5dc8f38583ee40c19b6f09138a95e012_A_4 = _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3[3];
                    #endif
                    surface.Alpha = _Split_5dc8f38583ee40c19b6f09138a95e012_A_4;
                    surface.AlphaClipThreshold = 0;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ObjectSpaceNormal =           input.normalOS;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ObjectSpaceTangent =          input.tangentOS;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ObjectSpacePosition =         input.positionOS;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpacePosition =          TransformObjectToWorld(input.positionOS);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.uv0 =                         input.uv0;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.TimeParameters =              _TimeParameters.xyz;
                #endif
                
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                
                
                
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpacePosition =          input.positionWS;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
                #endif
                
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
                #else
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                #endif
                #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                
                    return output;
                }
                
    
                // --------------------------------------------------
                // Main
    
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShadowCasterPass.hlsl"
    
                ENDHLSL
            }
            Pass
            {
                Name "DepthOnly"
                Tags
                {
                    "LightMode" = "DepthOnly"
                }
    
                // Render State
                Cull Back
                Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
                ZTest LEqual
                ZWrite On
                ColorMask 0
    
                // Debug
                // <None>
    
                // --------------------------------------------------
                // Pass
    
                HLSLPROGRAM
    
                // Pragmas
                #pragma target 4.5
                #pragma exclude_renderers d3d11_9x gles
                #pragma multi_compile_instancing
                #pragma multi_compile _ DOTS_INSTANCING_ON
                #pragma vertex vert
                #pragma fragment frag
    
                // DotsInstancingOptions: <None>
                // HybridV1InjectedBuiltinProperties: <None>
    
                // Keywords
                // PassKeywords: <None>
                #pragma shader_feature_local _ BOOLEAN_2D5E488208064DEDBE97E09FA59744E9_ON
                
                #if defined(BOOLEAN_2D5E488208064DEDBE97E09FA59744E9_ON)
                    #define KEYWORD_PERMUTATION_0
                #else
                    #define KEYWORD_PERMUTATION_1
                #endif
                
    
                // Defines
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define _SURFACE_TYPE_TRANSPARENT 1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define _AlphaClip 1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define _NORMALMAP 1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define _NORMAL_DROPOFF_TS 1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define ATTRIBUTES_NEED_NORMAL
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define ATTRIBUTES_NEED_TANGENT
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define ATTRIBUTES_NEED_TEXCOORD0
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define VARYINGS_NEED_POSITION_WS
            #endif
    
                #define FEATURES_GRAPH_VERTEX
                /* WARNING: $splice Could not find named fragment 'PassInstancing' */
                #define SHADERPASS SHADERPASS_DEPTHONLY
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #define REQUIRE_DEPTH_TEXTURE
                #endif
                /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
    
                // Includes
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
    
                // --------------------------------------------------
                // Structs and Packing
    
                struct Attributes
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 positionOS : POSITION;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 normalOS : NORMAL;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 tangentOS : TANGENT;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 uv0 : TEXCOORD0;
                    #endif
                    #if UNITY_ANY_INSTANCING_ENABLED
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint instanceID : INSTANCEID_SEMANTIC;
                    #endif
                    #endif
                };
                struct Varyings
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 positionCS : SV_POSITION;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 positionWS;
                    #endif
                    #if UNITY_ANY_INSTANCING_ENABLED
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                    #endif
                };
                struct SurfaceDescriptionInputs
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpacePosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 ScreenPosition;
                    #endif
                };
                struct VertexDescriptionInputs
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 ObjectSpaceNormal;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpaceNormal;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 ObjectSpaceTangent;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpaceTangent;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 ObjectSpaceBiTangent;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpaceBiTangent;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 ObjectSpacePosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpacePosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 uv0;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 TimeParameters;
                    #endif
                };
                struct PackedVaryings
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 positionCS : SV_POSITION;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 interp0 : TEXCOORD0;
                    #endif
                    #if UNITY_ANY_INSTANCING_ENABLED
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                    #endif
                };
    
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                PackedVaryings PackVaryings (Varyings input)
                    {
                        PackedVaryings output;
                        output.positionCS = input.positionCS;
                        output.interp0.xyz =  input.positionWS;
                        #if UNITY_ANY_INSTANCING_ENABLED
                        output.instanceID = input.instanceID;
                        #endif
                        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                        #endif
                        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                        #endif
                        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                        output.cullFace = input.cullFace;
                        #endif
                        return output;
                    }
                    Varyings UnpackVaryings (PackedVaryings input)
                    {
                        Varyings output;
                        output.positionCS = input.positionCS;
                        output.positionWS = input.interp0.xyz;
                        #if UNITY_ANY_INSTANCING_ENABLED
                        output.instanceID = input.instanceID;
                        #endif
                        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                        #endif
                        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                        #endif
                        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                        output.cullFace = input.cullFace;
                        #endif
                        return output;
                    }
                #endif
    
                // --------------------------------------------------
                // Graph
    
                // Graph Properties
                CBUFFER_START(UnityPerMaterial)
                float _depth;
                float _depthStrength;
                float4 _deepWaterColor;
                float4 _shallowWaterColor;
                float _smoothness;
                float _normalStrength;
                float _normalTiling;
                float _normalSpeed;
                float3 _mainNormalDirection;
                float3 _secondNormalDirection;
                float _amplitude;
                float _waves;
                float _wavesSpeed;
                CBUFFER_END
                TEXTURE2D(_mainNormal); SAMPLER(sampler_mainNormal); float4 _mainNormal_TexelSize;
                TEXTURE2D(_secondNormal); SAMPLER(sampler_secondNormal); float4 _secondNormal_TexelSize;
    
                // Graph Functions
                
                void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A / B;
                }
                
                void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                {
                    Out = UV * Tiling + Offset;
                }
                
                
                float2 Unity_GradientNoise_Dir_float(float2 p)
                {
                    // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
                    p = p % 289;
                    // need full precision, otherwise half overflows when p > 1
                    float x = float(34 * p.x + 1) * p.x % 289 + p.y;
                    x = (34 * x + 1) * x % 289;
                    x = frac(x / 41) * 2 - 1;
                    return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
                }
                
                void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
                { 
                    float2 p = UV * Scale;
                    float2 ip = floor(p);
                    float2 fp = frac(p);
                    float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
                    float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
                    float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
                    float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
                    fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
                    Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
                }
                
                void Unity_Add_float(float A, float B, out float Out)
                {
                    Out = A + B;
                }
                
                void Unity_Divide_float(float A, float B, out float Out)
                {
                    Out = A / B;
                }
                
                void Unity_Subtract_float(float A, float B, out float Out)
                {
                    Out = A - B;
                }
                
                void Unity_Multiply_float(float A, float B, out float Out)
                {
                    Out = A * B;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_SceneDepth_Linear01_float(float4 UV, out float Out)
                {
                    Out = Linear01Depth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
                }
                
                void Unity_Clamp_float(float In, float Min, float Max, out float Out)
                {
                    Out = clamp(In, Min, Max);
                }
                
                void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
                {
                    Out = lerp(A, B, T);
                }
    
                // Graph Vertex
                struct VertexDescription
                {
                    float3 Position;
                    float3 Normal;
                    float3 Tangent;
                };
                
                VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                {
                    VertexDescription description = (VertexDescription)0;
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Split_ff0fd34a61f44fd7ae2f222441749bd9_R_1 = IN.WorldSpacePosition[0];
                    float _Split_ff0fd34a61f44fd7ae2f222441749bd9_G_2 = IN.WorldSpacePosition[1];
                    float _Split_ff0fd34a61f44fd7ae2f222441749bd9_B_3 = IN.WorldSpacePosition[2];
                    float _Split_ff0fd34a61f44fd7ae2f222441749bd9_A_4 = 0;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_f4af681ed89a4a3d8c81333e9f8b562d_Out_0 = _waves;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Property_49ef859bb89c4a8288c9eb1583334fde_Out_0 = _mainNormalDirection;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_992df1e5e71b4479bbb5a25e534d8861_Out_2;
                    Unity_Multiply_float((IN.TimeParameters.x.xxx), _Property_49ef859bb89c4a8288c9eb1583334fde_Out_0, _Multiply_992df1e5e71b4479bbb5a25e534d8861_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Vector1_60e9a38039a843989ca21ba08ba76bd7_Out_0 = 5;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Divide_eb274efe27a64e71ba9baa084548bb6c_Out_2;
                    Unity_Divide_float3(_Multiply_992df1e5e71b4479bbb5a25e534d8861_Out_2, (_Vector1_60e9a38039a843989ca21ba08ba76bd7_Out_0.xxx), _Divide_eb274efe27a64e71ba9baa084548bb6c_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_92f37cd5909d40809e2b672d1636bd54_Out_0 = _wavesSpeed;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_afb804d1277148d7b992f652bb14e3be_Out_2;
                    Unity_Multiply_float(_Divide_eb274efe27a64e71ba9baa084548bb6c_Out_2, (_Property_92f37cd5909d40809e2b672d1636bd54_Out_0.xxx), _Multiply_afb804d1277148d7b992f652bb14e3be_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float2 _TilingAndOffset_05baded2421248cd9222b83233309dcb_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, (_Property_f4af681ed89a4a3d8c81333e9f8b562d_Out_0.xx), (_Multiply_afb804d1277148d7b992f652bb14e3be_Out_2.xy), _TilingAndOffset_05baded2421248cd9222b83233309dcb_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _GradientNoise_5b5f40a249b347c9be3b4afc6d0ed3ad_Out_2;
                    Unity_GradientNoise_float(_TilingAndOffset_05baded2421248cd9222b83233309dcb_Out_3, 10, _GradientNoise_5b5f40a249b347c9be3b4afc6d0ed3ad_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Property_666f9a531b564538acc376057bc6caa9_Out_0 = _secondNormalDirection;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_118898149cbd4850b0807b9467ed73b4_Out_2;
                    Unity_Multiply_float((IN.TimeParameters.x.xxx), _Property_666f9a531b564538acc376057bc6caa9_Out_0, _Multiply_118898149cbd4850b0807b9467ed73b4_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Vector1_ea96af95fe4f4961ad8bfc89f5bc9a03_Out_0 = 5;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Divide_b7c139d64ea9401fbda3a903c9fd1bf6_Out_2;
                    Unity_Divide_float3(_Multiply_118898149cbd4850b0807b9467ed73b4_Out_2, (_Vector1_ea96af95fe4f4961ad8bfc89f5bc9a03_Out_0.xxx), _Divide_b7c139d64ea9401fbda3a903c9fd1bf6_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_6199970682ac4c9c947732b8aa1e32b0_Out_2;
                    Unity_Multiply_float(_Divide_b7c139d64ea9401fbda3a903c9fd1bf6_Out_2, (_Property_92f37cd5909d40809e2b672d1636bd54_Out_0.xxx), _Multiply_6199970682ac4c9c947732b8aa1e32b0_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float2 _TilingAndOffset_2d869c568f8c4bd1935e9e1a5d383ff4_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, (_Property_f4af681ed89a4a3d8c81333e9f8b562d_Out_0.xx), (_Multiply_6199970682ac4c9c947732b8aa1e32b0_Out_2.xy), _TilingAndOffset_2d869c568f8c4bd1935e9e1a5d383ff4_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _GradientNoise_7d50ab18cca7435cbe45ace0410a84c7_Out_2;
                    Unity_GradientNoise_float(_TilingAndOffset_2d869c568f8c4bd1935e9e1a5d383ff4_Out_3, 10, _GradientNoise_7d50ab18cca7435cbe45ace0410a84c7_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Add_3ab7d42c644a4df381d663f07b7ab1e9_Out_2;
                    Unity_Add_float(_GradientNoise_5b5f40a249b347c9be3b4afc6d0ed3ad_Out_2, _GradientNoise_7d50ab18cca7435cbe45ace0410a84c7_Out_2, _Add_3ab7d42c644a4df381d663f07b7ab1e9_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Divide_cefb6bacdd4e476ea8103edefe43f584_Out_2;
                    Unity_Divide_float(_Add_3ab7d42c644a4df381d663f07b7ab1e9_Out_2, 2, _Divide_cefb6bacdd4e476ea8103edefe43f584_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Subtract_4da7b6862bcc45eca57cbd26b806eaf0_Out_2;
                    Unity_Subtract_float(_Divide_cefb6bacdd4e476ea8103edefe43f584_Out_2, 0.61, _Subtract_4da7b6862bcc45eca57cbd26b806eaf0_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_ce933f1cb0934b47a86069374aea82d8_Out_0 = _amplitude;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Multiply_fc80491e653843f7b95b7d963584d21d_Out_2;
                    Unity_Multiply_float(_Subtract_4da7b6862bcc45eca57cbd26b806eaf0_Out_2, _Property_ce933f1cb0934b47a86069374aea82d8_Out_0, _Multiply_fc80491e653843f7b95b7d963584d21d_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Combine_4394e5327dea4ebda9c6b40c020e0721_RGBA_4;
                    float3 _Combine_4394e5327dea4ebda9c6b40c020e0721_RGB_5;
                    float2 _Combine_4394e5327dea4ebda9c6b40c020e0721_RG_6;
                    Unity_Combine_float(_Split_ff0fd34a61f44fd7ae2f222441749bd9_R_1, _Multiply_fc80491e653843f7b95b7d963584d21d_Out_2, _Split_ff0fd34a61f44fd7ae2f222441749bd9_B_3, 0, _Combine_4394e5327dea4ebda9c6b40c020e0721_RGBA_4, _Combine_4394e5327dea4ebda9c6b40c020e0721_RGB_5, _Combine_4394e5327dea4ebda9c6b40c020e0721_RG_6);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Transform_5f6d055972de4e69871e05659dc0cf87_Out_1 = TransformWorldToObject(_Combine_4394e5327dea4ebda9c6b40c020e0721_RGB_5.xyz);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Combine_989bd6296fa44c898dce3b24fde18c9d_RGBA_4;
                    float3 _Combine_989bd6296fa44c898dce3b24fde18c9d_RGB_5;
                    float2 _Combine_989bd6296fa44c898dce3b24fde18c9d_RG_6;
                    Unity_Combine_float(_Split_ff0fd34a61f44fd7ae2f222441749bd9_R_1, _Split_ff0fd34a61f44fd7ae2f222441749bd9_G_2, _Split_ff0fd34a61f44fd7ae2f222441749bd9_B_3, 0, _Combine_989bd6296fa44c898dce3b24fde18c9d_RGBA_4, _Combine_989bd6296fa44c898dce3b24fde18c9d_RGB_5, _Combine_989bd6296fa44c898dce3b24fde18c9d_RG_6);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    #if defined(BOOLEAN_2D5E488208064DEDBE97E09FA59744E9_ON)
                    float3 _Waving_e9c7407f61464da88e74e85183ca2065_Out_0 = _Transform_5f6d055972de4e69871e05659dc0cf87_Out_1;
                    #else
                    float3 _Waving_e9c7407f61464da88e74e85183ca2065_Out_0 = _Combine_989bd6296fa44c898dce3b24fde18c9d_RGB_5;
                    #endif
                    #endif
                    description.Position = _Waving_e9c7407f61464da88e74e85183ca2065_Out_0;
                    description.Normal = IN.ObjectSpaceNormal;
                    description.Tangent = IN.ObjectSpaceTangent;
                    return description;
                }
    
                // Graph Pixel
                struct SurfaceDescription
                {
                    float Alpha;
                    float AlphaClipThreshold;
                };
                
                SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                {
                    SurfaceDescription surface = (SurfaceDescription)0;
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Property_cd262e3649c94d36ac1a6035934c82ba_Out_0 = _shallowWaterColor;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Property_c08d4525fbf641d78eb168f9e6c77374_Out_0 = _deepWaterColor;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _SceneDepth_ff2814420f634b6c9006b17db1b0db86_Out_1;
                    Unity_SceneDepth_Linear01_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_ff2814420f634b6c9006b17db1b0db86_Out_1);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Multiply_7fe029570de94c259af598c01f1e9fc7_Out_2;
                    Unity_Multiply_float(_SceneDepth_ff2814420f634b6c9006b17db1b0db86_Out_1, _ProjectionParams.z, _Multiply_7fe029570de94c259af598c01f1e9fc7_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_69b3cbbc42e345ba9fcd9de510b5e2d7_Out_0 = _depth;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0 = IN.ScreenPosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Split_4da6c10dd6e44537a1e2021901925b9e_R_1 = _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0[0];
                    float _Split_4da6c10dd6e44537a1e2021901925b9e_G_2 = _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0[1];
                    float _Split_4da6c10dd6e44537a1e2021901925b9e_B_3 = _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0[2];
                    float _Split_4da6c10dd6e44537a1e2021901925b9e_A_4 = _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0[3];
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Add_5516261d5322477cbf6c851a3128394f_Out_2;
                    Unity_Add_float(_Property_69b3cbbc42e345ba9fcd9de510b5e2d7_Out_0, _Split_4da6c10dd6e44537a1e2021901925b9e_A_4, _Add_5516261d5322477cbf6c851a3128394f_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Subtract_f153dba44eeb4c808ffd45ea4a4f742e_Out_2;
                    Unity_Subtract_float(_Multiply_7fe029570de94c259af598c01f1e9fc7_Out_2, _Add_5516261d5322477cbf6c851a3128394f_Out_2, _Subtract_f153dba44eeb4c808ffd45ea4a4f742e_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_3b327dff25184e83be825e3db1854a26_Out_0 = _depthStrength;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Multiply_bcf5cd29cecf4b4f97083346027d340a_Out_2;
                    Unity_Multiply_float(_Subtract_f153dba44eeb4c808ffd45ea4a4f742e_Out_2, _Property_3b327dff25184e83be825e3db1854a26_Out_0, _Multiply_bcf5cd29cecf4b4f97083346027d340a_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Clamp_07516fbacac148a2ab07ae8f0615108e_Out_3;
                    Unity_Clamp_float(_Multiply_bcf5cd29cecf4b4f97083346027d340a_Out_2, 0, 1, _Clamp_07516fbacac148a2ab07ae8f0615108e_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3;
                    Unity_Lerp_float4(_Property_cd262e3649c94d36ac1a6035934c82ba_Out_0, _Property_c08d4525fbf641d78eb168f9e6c77374_Out_0, (_Clamp_07516fbacac148a2ab07ae8f0615108e_Out_3.xxxx), _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Split_5dc8f38583ee40c19b6f09138a95e012_R_1 = _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3[0];
                    float _Split_5dc8f38583ee40c19b6f09138a95e012_G_2 = _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3[1];
                    float _Split_5dc8f38583ee40c19b6f09138a95e012_B_3 = _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3[2];
                    float _Split_5dc8f38583ee40c19b6f09138a95e012_A_4 = _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3[3];
                    #endif
                    surface.Alpha = _Split_5dc8f38583ee40c19b6f09138a95e012_A_4;
                    surface.AlphaClipThreshold = 0;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ObjectSpaceNormal =           input.normalOS;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ObjectSpaceTangent =          input.tangentOS;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ObjectSpacePosition =         input.positionOS;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpacePosition =          TransformObjectToWorld(input.positionOS);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.uv0 =                         input.uv0;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.TimeParameters =              _TimeParameters.xyz;
                #endif
                
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                
                
                
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpacePosition =          input.positionWS;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
                #endif
                
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
                #else
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                #endif
                #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                
                    return output;
                }
                
    
                // --------------------------------------------------
                // Main
    
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthOnlyPass.hlsl"
    
                ENDHLSL
            }
            Pass
            {
                Name "Meta"
                Tags
                {
                    "LightMode" = "Meta"
                }
    
                // Render State
                Cull Back
                Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
                ZTest LEqual
                ZWrite On
    
                // Debug
                // <None>
    
                // --------------------------------------------------
                // Pass
    
                HLSLPROGRAM
    
                // Pragmas
                #pragma target 4.5
                #pragma exclude_renderers d3d11_9x gles
                #pragma vertex vert
                #pragma fragment frag
    
                // DotsInstancingOptions: <None>
                // HybridV1InjectedBuiltinProperties: <None>
    
                // Keywords
                #pragma shader_feature _ _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A
                #pragma shader_feature_local _ BOOLEAN_2D5E488208064DEDBE97E09FA59744E9_ON
                
                #if defined(BOOLEAN_2D5E488208064DEDBE97E09FA59744E9_ON)
                    #define KEYWORD_PERMUTATION_0
                #else
                    #define KEYWORD_PERMUTATION_1
                #endif
                
    
                // Defines
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define _SURFACE_TYPE_TRANSPARENT 1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define _AlphaClip 1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define _NORMALMAP 1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define _NORMAL_DROPOFF_TS 1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define ATTRIBUTES_NEED_NORMAL
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define ATTRIBUTES_NEED_TANGENT
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define ATTRIBUTES_NEED_TEXCOORD0
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define ATTRIBUTES_NEED_TEXCOORD1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define ATTRIBUTES_NEED_TEXCOORD2
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define VARYINGS_NEED_POSITION_WS
            #endif
    
                #define FEATURES_GRAPH_VERTEX
                /* WARNING: $splice Could not find named fragment 'PassInstancing' */
                #define SHADERPASS SHADERPASS_META
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #define REQUIRE_DEPTH_TEXTURE
                #endif
                /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
    
                // Includes
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/MetaInput.hlsl"
    
                // --------------------------------------------------
                // Structs and Packing
    
                struct Attributes
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 positionOS : POSITION;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 normalOS : NORMAL;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 tangentOS : TANGENT;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 uv0 : TEXCOORD0;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 uv1 : TEXCOORD1;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 uv2 : TEXCOORD2;
                    #endif
                    #if UNITY_ANY_INSTANCING_ENABLED
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint instanceID : INSTANCEID_SEMANTIC;
                    #endif
                    #endif
                };
                struct Varyings
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 positionCS : SV_POSITION;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 positionWS;
                    #endif
                    #if UNITY_ANY_INSTANCING_ENABLED
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                    #endif
                };
                struct SurfaceDescriptionInputs
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpacePosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 ScreenPosition;
                    #endif
                };
                struct VertexDescriptionInputs
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 ObjectSpaceNormal;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpaceNormal;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 ObjectSpaceTangent;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpaceTangent;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 ObjectSpaceBiTangent;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpaceBiTangent;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 ObjectSpacePosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpacePosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 uv0;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 TimeParameters;
                    #endif
                };
                struct PackedVaryings
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 positionCS : SV_POSITION;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 interp0 : TEXCOORD0;
                    #endif
                    #if UNITY_ANY_INSTANCING_ENABLED
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                    #endif
                };
    
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                PackedVaryings PackVaryings (Varyings input)
                    {
                        PackedVaryings output;
                        output.positionCS = input.positionCS;
                        output.interp0.xyz =  input.positionWS;
                        #if UNITY_ANY_INSTANCING_ENABLED
                        output.instanceID = input.instanceID;
                        #endif
                        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                        #endif
                        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                        #endif
                        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                        output.cullFace = input.cullFace;
                        #endif
                        return output;
                    }
                    Varyings UnpackVaryings (PackedVaryings input)
                    {
                        Varyings output;
                        output.positionCS = input.positionCS;
                        output.positionWS = input.interp0.xyz;
                        #if UNITY_ANY_INSTANCING_ENABLED
                        output.instanceID = input.instanceID;
                        #endif
                        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                        #endif
                        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                        #endif
                        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                        output.cullFace = input.cullFace;
                        #endif
                        return output;
                    }
                #endif
    
                // --------------------------------------------------
                // Graph
    
                // Graph Properties
                CBUFFER_START(UnityPerMaterial)
                float _depth;
                float _depthStrength;
                float4 _deepWaterColor;
                float4 _shallowWaterColor;
                float _smoothness;
                float _normalStrength;
                float _normalTiling;
                float _normalSpeed;
                float3 _mainNormalDirection;
                float3 _secondNormalDirection;
                float _amplitude;
                float _waves;
                float _wavesSpeed;
                CBUFFER_END
                TEXTURE2D(_mainNormal); SAMPLER(sampler_mainNormal); float4 _mainNormal_TexelSize;
                TEXTURE2D(_secondNormal); SAMPLER(sampler_secondNormal); float4 _secondNormal_TexelSize;
    
                // Graph Functions
                
                void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A / B;
                }
                
                void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                {
                    Out = UV * Tiling + Offset;
                }
                
                
                float2 Unity_GradientNoise_Dir_float(float2 p)
                {
                    // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
                    p = p % 289;
                    // need full precision, otherwise half overflows when p > 1
                    float x = float(34 * p.x + 1) * p.x % 289 + p.y;
                    x = (34 * x + 1) * x % 289;
                    x = frac(x / 41) * 2 - 1;
                    return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
                }
                
                void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
                { 
                    float2 p = UV * Scale;
                    float2 ip = floor(p);
                    float2 fp = frac(p);
                    float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
                    float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
                    float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
                    float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
                    fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
                    Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
                }
                
                void Unity_Add_float(float A, float B, out float Out)
                {
                    Out = A + B;
                }
                
                void Unity_Divide_float(float A, float B, out float Out)
                {
                    Out = A / B;
                }
                
                void Unity_Subtract_float(float A, float B, out float Out)
                {
                    Out = A - B;
                }
                
                void Unity_Multiply_float(float A, float B, out float Out)
                {
                    Out = A * B;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_SceneDepth_Linear01_float(float4 UV, out float Out)
                {
                    Out = Linear01Depth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
                }
                
                void Unity_Clamp_float(float In, float Min, float Max, out float Out)
                {
                    Out = clamp(In, Min, Max);
                }
                
                void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
                {
                    Out = lerp(A, B, T);
                }
    
                // Graph Vertex
                struct VertexDescription
                {
                    float3 Position;
                    float3 Normal;
                    float3 Tangent;
                };
                
                VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                {
                    VertexDescription description = (VertexDescription)0;
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Split_ff0fd34a61f44fd7ae2f222441749bd9_R_1 = IN.WorldSpacePosition[0];
                    float _Split_ff0fd34a61f44fd7ae2f222441749bd9_G_2 = IN.WorldSpacePosition[1];
                    float _Split_ff0fd34a61f44fd7ae2f222441749bd9_B_3 = IN.WorldSpacePosition[2];
                    float _Split_ff0fd34a61f44fd7ae2f222441749bd9_A_4 = 0;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_f4af681ed89a4a3d8c81333e9f8b562d_Out_0 = _waves;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Property_49ef859bb89c4a8288c9eb1583334fde_Out_0 = _mainNormalDirection;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_992df1e5e71b4479bbb5a25e534d8861_Out_2;
                    Unity_Multiply_float((IN.TimeParameters.x.xxx), _Property_49ef859bb89c4a8288c9eb1583334fde_Out_0, _Multiply_992df1e5e71b4479bbb5a25e534d8861_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Vector1_60e9a38039a843989ca21ba08ba76bd7_Out_0 = 5;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Divide_eb274efe27a64e71ba9baa084548bb6c_Out_2;
                    Unity_Divide_float3(_Multiply_992df1e5e71b4479bbb5a25e534d8861_Out_2, (_Vector1_60e9a38039a843989ca21ba08ba76bd7_Out_0.xxx), _Divide_eb274efe27a64e71ba9baa084548bb6c_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_92f37cd5909d40809e2b672d1636bd54_Out_0 = _wavesSpeed;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_afb804d1277148d7b992f652bb14e3be_Out_2;
                    Unity_Multiply_float(_Divide_eb274efe27a64e71ba9baa084548bb6c_Out_2, (_Property_92f37cd5909d40809e2b672d1636bd54_Out_0.xxx), _Multiply_afb804d1277148d7b992f652bb14e3be_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float2 _TilingAndOffset_05baded2421248cd9222b83233309dcb_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, (_Property_f4af681ed89a4a3d8c81333e9f8b562d_Out_0.xx), (_Multiply_afb804d1277148d7b992f652bb14e3be_Out_2.xy), _TilingAndOffset_05baded2421248cd9222b83233309dcb_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _GradientNoise_5b5f40a249b347c9be3b4afc6d0ed3ad_Out_2;
                    Unity_GradientNoise_float(_TilingAndOffset_05baded2421248cd9222b83233309dcb_Out_3, 10, _GradientNoise_5b5f40a249b347c9be3b4afc6d0ed3ad_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Property_666f9a531b564538acc376057bc6caa9_Out_0 = _secondNormalDirection;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_118898149cbd4850b0807b9467ed73b4_Out_2;
                    Unity_Multiply_float((IN.TimeParameters.x.xxx), _Property_666f9a531b564538acc376057bc6caa9_Out_0, _Multiply_118898149cbd4850b0807b9467ed73b4_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Vector1_ea96af95fe4f4961ad8bfc89f5bc9a03_Out_0 = 5;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Divide_b7c139d64ea9401fbda3a903c9fd1bf6_Out_2;
                    Unity_Divide_float3(_Multiply_118898149cbd4850b0807b9467ed73b4_Out_2, (_Vector1_ea96af95fe4f4961ad8bfc89f5bc9a03_Out_0.xxx), _Divide_b7c139d64ea9401fbda3a903c9fd1bf6_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_6199970682ac4c9c947732b8aa1e32b0_Out_2;
                    Unity_Multiply_float(_Divide_b7c139d64ea9401fbda3a903c9fd1bf6_Out_2, (_Property_92f37cd5909d40809e2b672d1636bd54_Out_0.xxx), _Multiply_6199970682ac4c9c947732b8aa1e32b0_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float2 _TilingAndOffset_2d869c568f8c4bd1935e9e1a5d383ff4_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, (_Property_f4af681ed89a4a3d8c81333e9f8b562d_Out_0.xx), (_Multiply_6199970682ac4c9c947732b8aa1e32b0_Out_2.xy), _TilingAndOffset_2d869c568f8c4bd1935e9e1a5d383ff4_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _GradientNoise_7d50ab18cca7435cbe45ace0410a84c7_Out_2;
                    Unity_GradientNoise_float(_TilingAndOffset_2d869c568f8c4bd1935e9e1a5d383ff4_Out_3, 10, _GradientNoise_7d50ab18cca7435cbe45ace0410a84c7_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Add_3ab7d42c644a4df381d663f07b7ab1e9_Out_2;
                    Unity_Add_float(_GradientNoise_5b5f40a249b347c9be3b4afc6d0ed3ad_Out_2, _GradientNoise_7d50ab18cca7435cbe45ace0410a84c7_Out_2, _Add_3ab7d42c644a4df381d663f07b7ab1e9_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Divide_cefb6bacdd4e476ea8103edefe43f584_Out_2;
                    Unity_Divide_float(_Add_3ab7d42c644a4df381d663f07b7ab1e9_Out_2, 2, _Divide_cefb6bacdd4e476ea8103edefe43f584_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Subtract_4da7b6862bcc45eca57cbd26b806eaf0_Out_2;
                    Unity_Subtract_float(_Divide_cefb6bacdd4e476ea8103edefe43f584_Out_2, 0.61, _Subtract_4da7b6862bcc45eca57cbd26b806eaf0_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_ce933f1cb0934b47a86069374aea82d8_Out_0 = _amplitude;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Multiply_fc80491e653843f7b95b7d963584d21d_Out_2;
                    Unity_Multiply_float(_Subtract_4da7b6862bcc45eca57cbd26b806eaf0_Out_2, _Property_ce933f1cb0934b47a86069374aea82d8_Out_0, _Multiply_fc80491e653843f7b95b7d963584d21d_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Combine_4394e5327dea4ebda9c6b40c020e0721_RGBA_4;
                    float3 _Combine_4394e5327dea4ebda9c6b40c020e0721_RGB_5;
                    float2 _Combine_4394e5327dea4ebda9c6b40c020e0721_RG_6;
                    Unity_Combine_float(_Split_ff0fd34a61f44fd7ae2f222441749bd9_R_1, _Multiply_fc80491e653843f7b95b7d963584d21d_Out_2, _Split_ff0fd34a61f44fd7ae2f222441749bd9_B_3, 0, _Combine_4394e5327dea4ebda9c6b40c020e0721_RGBA_4, _Combine_4394e5327dea4ebda9c6b40c020e0721_RGB_5, _Combine_4394e5327dea4ebda9c6b40c020e0721_RG_6);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Transform_5f6d055972de4e69871e05659dc0cf87_Out_1 = TransformWorldToObject(_Combine_4394e5327dea4ebda9c6b40c020e0721_RGB_5.xyz);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Combine_989bd6296fa44c898dce3b24fde18c9d_RGBA_4;
                    float3 _Combine_989bd6296fa44c898dce3b24fde18c9d_RGB_5;
                    float2 _Combine_989bd6296fa44c898dce3b24fde18c9d_RG_6;
                    Unity_Combine_float(_Split_ff0fd34a61f44fd7ae2f222441749bd9_R_1, _Split_ff0fd34a61f44fd7ae2f222441749bd9_G_2, _Split_ff0fd34a61f44fd7ae2f222441749bd9_B_3, 0, _Combine_989bd6296fa44c898dce3b24fde18c9d_RGBA_4, _Combine_989bd6296fa44c898dce3b24fde18c9d_RGB_5, _Combine_989bd6296fa44c898dce3b24fde18c9d_RG_6);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    #if defined(BOOLEAN_2D5E488208064DEDBE97E09FA59744E9_ON)
                    float3 _Waving_e9c7407f61464da88e74e85183ca2065_Out_0 = _Transform_5f6d055972de4e69871e05659dc0cf87_Out_1;
                    #else
                    float3 _Waving_e9c7407f61464da88e74e85183ca2065_Out_0 = _Combine_989bd6296fa44c898dce3b24fde18c9d_RGB_5;
                    #endif
                    #endif
                    description.Position = _Waving_e9c7407f61464da88e74e85183ca2065_Out_0;
                    description.Normal = IN.ObjectSpaceNormal;
                    description.Tangent = IN.ObjectSpaceTangent;
                    return description;
                }
    
                // Graph Pixel
                struct SurfaceDescription
                {
                    float3 BaseColor;
                    float3 Emission;
                    float Alpha;
                    float AlphaClipThreshold;
                };
                
                SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                {
                    SurfaceDescription surface = (SurfaceDescription)0;
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Property_cd262e3649c94d36ac1a6035934c82ba_Out_0 = _shallowWaterColor;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Property_c08d4525fbf641d78eb168f9e6c77374_Out_0 = _deepWaterColor;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _SceneDepth_ff2814420f634b6c9006b17db1b0db86_Out_1;
                    Unity_SceneDepth_Linear01_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_ff2814420f634b6c9006b17db1b0db86_Out_1);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Multiply_7fe029570de94c259af598c01f1e9fc7_Out_2;
                    Unity_Multiply_float(_SceneDepth_ff2814420f634b6c9006b17db1b0db86_Out_1, _ProjectionParams.z, _Multiply_7fe029570de94c259af598c01f1e9fc7_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_69b3cbbc42e345ba9fcd9de510b5e2d7_Out_0 = _depth;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0 = IN.ScreenPosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Split_4da6c10dd6e44537a1e2021901925b9e_R_1 = _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0[0];
                    float _Split_4da6c10dd6e44537a1e2021901925b9e_G_2 = _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0[1];
                    float _Split_4da6c10dd6e44537a1e2021901925b9e_B_3 = _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0[2];
                    float _Split_4da6c10dd6e44537a1e2021901925b9e_A_4 = _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0[3];
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Add_5516261d5322477cbf6c851a3128394f_Out_2;
                    Unity_Add_float(_Property_69b3cbbc42e345ba9fcd9de510b5e2d7_Out_0, _Split_4da6c10dd6e44537a1e2021901925b9e_A_4, _Add_5516261d5322477cbf6c851a3128394f_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Subtract_f153dba44eeb4c808ffd45ea4a4f742e_Out_2;
                    Unity_Subtract_float(_Multiply_7fe029570de94c259af598c01f1e9fc7_Out_2, _Add_5516261d5322477cbf6c851a3128394f_Out_2, _Subtract_f153dba44eeb4c808ffd45ea4a4f742e_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_3b327dff25184e83be825e3db1854a26_Out_0 = _depthStrength;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Multiply_bcf5cd29cecf4b4f97083346027d340a_Out_2;
                    Unity_Multiply_float(_Subtract_f153dba44eeb4c808ffd45ea4a4f742e_Out_2, _Property_3b327dff25184e83be825e3db1854a26_Out_0, _Multiply_bcf5cd29cecf4b4f97083346027d340a_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Clamp_07516fbacac148a2ab07ae8f0615108e_Out_3;
                    Unity_Clamp_float(_Multiply_bcf5cd29cecf4b4f97083346027d340a_Out_2, 0, 1, _Clamp_07516fbacac148a2ab07ae8f0615108e_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3;
                    Unity_Lerp_float4(_Property_cd262e3649c94d36ac1a6035934c82ba_Out_0, _Property_c08d4525fbf641d78eb168f9e6c77374_Out_0, (_Clamp_07516fbacac148a2ab07ae8f0615108e_Out_3.xxxx), _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Split_5dc8f38583ee40c19b6f09138a95e012_R_1 = _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3[0];
                    float _Split_5dc8f38583ee40c19b6f09138a95e012_G_2 = _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3[1];
                    float _Split_5dc8f38583ee40c19b6f09138a95e012_B_3 = _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3[2];
                    float _Split_5dc8f38583ee40c19b6f09138a95e012_A_4 = _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3[3];
                    #endif
                    surface.BaseColor = (_Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3.xyz);
                    surface.Emission = float3(0, 0, 0);
                    surface.Alpha = _Split_5dc8f38583ee40c19b6f09138a95e012_A_4;
                    surface.AlphaClipThreshold = 0;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ObjectSpaceNormal =           input.normalOS;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ObjectSpaceTangent =          input.tangentOS;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ObjectSpacePosition =         input.positionOS;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpacePosition =          TransformObjectToWorld(input.positionOS);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.uv0 =                         input.uv0;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.TimeParameters =              _TimeParameters.xyz;
                #endif
                
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                
                
                
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpacePosition =          input.positionWS;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
                #endif
                
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
                #else
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                #endif
                #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                
                    return output;
                }
                
    
                // --------------------------------------------------
                // Main
    
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/LightingMetaPass.hlsl"
    
                ENDHLSL
            }
            Pass
            {
                // Name: <None>
                Tags
                {
                    "LightMode" = "Universal2D"
                }
    
                // Render State
                Cull Back
                Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
                ZTest LEqual
                ZWrite Off
    
                // Debug
                // <None>
    
                // --------------------------------------------------
                // Pass
    
                HLSLPROGRAM
    
                // Pragmas
                #pragma target 4.5
                #pragma exclude_renderers d3d11_9x gles
                #pragma vertex vert
                #pragma fragment frag
    
                // DotsInstancingOptions: <None>
                // HybridV1InjectedBuiltinProperties: <None>
    
                // Keywords
                // PassKeywords: <None>
                #pragma shader_feature_local _ BOOLEAN_2D5E488208064DEDBE97E09FA59744E9_ON
                
                #if defined(BOOLEAN_2D5E488208064DEDBE97E09FA59744E9_ON)
                    #define KEYWORD_PERMUTATION_0
                #else
                    #define KEYWORD_PERMUTATION_1
                #endif
                
    
                // Defines
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define _SURFACE_TYPE_TRANSPARENT 1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define _AlphaClip 1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define _NORMALMAP 1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define _NORMAL_DROPOFF_TS 1
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define ATTRIBUTES_NEED_NORMAL
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define ATTRIBUTES_NEED_TANGENT
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define ATTRIBUTES_NEED_TEXCOORD0
            #endif
    
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define VARYINGS_NEED_POSITION_WS
            #endif
    
                #define FEATURES_GRAPH_VERTEX
                /* WARNING: $splice Could not find named fragment 'PassInstancing' */
                #define SHADERPASS SHADERPASS_2D
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #define REQUIRE_DEPTH_TEXTURE
                #endif
                /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
    
                // Includes
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
    
                // --------------------------------------------------
                // Structs and Packing
    
                struct Attributes
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 positionOS : POSITION;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 normalOS : NORMAL;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 tangentOS : TANGENT;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 uv0 : TEXCOORD0;
                    #endif
                    #if UNITY_ANY_INSTANCING_ENABLED
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint instanceID : INSTANCEID_SEMANTIC;
                    #endif
                    #endif
                };
                struct Varyings
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 positionCS : SV_POSITION;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 positionWS;
                    #endif
                    #if UNITY_ANY_INSTANCING_ENABLED
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                    #endif
                };
                struct SurfaceDescriptionInputs
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpacePosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 ScreenPosition;
                    #endif
                };
                struct VertexDescriptionInputs
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 ObjectSpaceNormal;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpaceNormal;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 ObjectSpaceTangent;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpaceTangent;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 ObjectSpaceBiTangent;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpaceBiTangent;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 ObjectSpacePosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 WorldSpacePosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 uv0;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 TimeParameters;
                    #endif
                };
                struct PackedVaryings
                {
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 positionCS : SV_POSITION;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 interp0 : TEXCOORD0;
                    #endif
                    #if UNITY_ANY_INSTANCING_ENABLED
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                    #endif
                };
    
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                PackedVaryings PackVaryings (Varyings input)
                    {
                        PackedVaryings output;
                        output.positionCS = input.positionCS;
                        output.interp0.xyz =  input.positionWS;
                        #if UNITY_ANY_INSTANCING_ENABLED
                        output.instanceID = input.instanceID;
                        #endif
                        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                        #endif
                        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                        #endif
                        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                        output.cullFace = input.cullFace;
                        #endif
                        return output;
                    }
                    Varyings UnpackVaryings (PackedVaryings input)
                    {
                        Varyings output;
                        output.positionCS = input.positionCS;
                        output.positionWS = input.interp0.xyz;
                        #if UNITY_ANY_INSTANCING_ENABLED
                        output.instanceID = input.instanceID;
                        #endif
                        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                        #endif
                        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                        #endif
                        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                        output.cullFace = input.cullFace;
                        #endif
                        return output;
                    }
                #endif
    
                // --------------------------------------------------
                // Graph
    
                // Graph Properties
                CBUFFER_START(UnityPerMaterial)
                float _depth;
                float _depthStrength;
                float4 _deepWaterColor;
                float4 _shallowWaterColor;
                float _smoothness;
                float _normalStrength;
                float _normalTiling;
                float _normalSpeed;
                float3 _mainNormalDirection;
                float3 _secondNormalDirection;
                float _amplitude;
                float _waves;
                float _wavesSpeed;
                CBUFFER_END
                TEXTURE2D(_mainNormal); SAMPLER(sampler_mainNormal); float4 _mainNormal_TexelSize;
                TEXTURE2D(_secondNormal); SAMPLER(sampler_secondNormal); float4 _secondNormal_TexelSize;
    
                // Graph Functions
                
                void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A / B;
                }
                
                void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                {
                    Out = UV * Tiling + Offset;
                }
                
                
                float2 Unity_GradientNoise_Dir_float(float2 p)
                {
                    // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
                    p = p % 289;
                    // need full precision, otherwise half overflows when p > 1
                    float x = float(34 * p.x + 1) * p.x % 289 + p.y;
                    x = (34 * x + 1) * x % 289;
                    x = frac(x / 41) * 2 - 1;
                    return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
                }
                
                void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
                { 
                    float2 p = UV * Scale;
                    float2 ip = floor(p);
                    float2 fp = frac(p);
                    float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
                    float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
                    float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
                    float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
                    fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
                    Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
                }
                
                void Unity_Add_float(float A, float B, out float Out)
                {
                    Out = A + B;
                }
                
                void Unity_Divide_float(float A, float B, out float Out)
                {
                    Out = A / B;
                }
                
                void Unity_Subtract_float(float A, float B, out float Out)
                {
                    Out = A - B;
                }
                
                void Unity_Multiply_float(float A, float B, out float Out)
                {
                    Out = A * B;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_SceneDepth_Linear01_float(float4 UV, out float Out)
                {
                    Out = Linear01Depth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
                }
                
                void Unity_Clamp_float(float In, float Min, float Max, out float Out)
                {
                    Out = clamp(In, Min, Max);
                }
                
                void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
                {
                    Out = lerp(A, B, T);
                }
    
                // Graph Vertex
                struct VertexDescription
                {
                    float3 Position;
                    float3 Normal;
                    float3 Tangent;
                };
                
                VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                {
                    VertexDescription description = (VertexDescription)0;
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Split_ff0fd34a61f44fd7ae2f222441749bd9_R_1 = IN.WorldSpacePosition[0];
                    float _Split_ff0fd34a61f44fd7ae2f222441749bd9_G_2 = IN.WorldSpacePosition[1];
                    float _Split_ff0fd34a61f44fd7ae2f222441749bd9_B_3 = IN.WorldSpacePosition[2];
                    float _Split_ff0fd34a61f44fd7ae2f222441749bd9_A_4 = 0;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_f4af681ed89a4a3d8c81333e9f8b562d_Out_0 = _waves;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Property_49ef859bb89c4a8288c9eb1583334fde_Out_0 = _mainNormalDirection;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_992df1e5e71b4479bbb5a25e534d8861_Out_2;
                    Unity_Multiply_float((IN.TimeParameters.x.xxx), _Property_49ef859bb89c4a8288c9eb1583334fde_Out_0, _Multiply_992df1e5e71b4479bbb5a25e534d8861_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Vector1_60e9a38039a843989ca21ba08ba76bd7_Out_0 = 5;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Divide_eb274efe27a64e71ba9baa084548bb6c_Out_2;
                    Unity_Divide_float3(_Multiply_992df1e5e71b4479bbb5a25e534d8861_Out_2, (_Vector1_60e9a38039a843989ca21ba08ba76bd7_Out_0.xxx), _Divide_eb274efe27a64e71ba9baa084548bb6c_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_92f37cd5909d40809e2b672d1636bd54_Out_0 = _wavesSpeed;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_afb804d1277148d7b992f652bb14e3be_Out_2;
                    Unity_Multiply_float(_Divide_eb274efe27a64e71ba9baa084548bb6c_Out_2, (_Property_92f37cd5909d40809e2b672d1636bd54_Out_0.xxx), _Multiply_afb804d1277148d7b992f652bb14e3be_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float2 _TilingAndOffset_05baded2421248cd9222b83233309dcb_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, (_Property_f4af681ed89a4a3d8c81333e9f8b562d_Out_0.xx), (_Multiply_afb804d1277148d7b992f652bb14e3be_Out_2.xy), _TilingAndOffset_05baded2421248cd9222b83233309dcb_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _GradientNoise_5b5f40a249b347c9be3b4afc6d0ed3ad_Out_2;
                    Unity_GradientNoise_float(_TilingAndOffset_05baded2421248cd9222b83233309dcb_Out_3, 10, _GradientNoise_5b5f40a249b347c9be3b4afc6d0ed3ad_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Property_666f9a531b564538acc376057bc6caa9_Out_0 = _secondNormalDirection;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_118898149cbd4850b0807b9467ed73b4_Out_2;
                    Unity_Multiply_float((IN.TimeParameters.x.xxx), _Property_666f9a531b564538acc376057bc6caa9_Out_0, _Multiply_118898149cbd4850b0807b9467ed73b4_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Vector1_ea96af95fe4f4961ad8bfc89f5bc9a03_Out_0 = 5;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Divide_b7c139d64ea9401fbda3a903c9fd1bf6_Out_2;
                    Unity_Divide_float3(_Multiply_118898149cbd4850b0807b9467ed73b4_Out_2, (_Vector1_ea96af95fe4f4961ad8bfc89f5bc9a03_Out_0.xxx), _Divide_b7c139d64ea9401fbda3a903c9fd1bf6_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Multiply_6199970682ac4c9c947732b8aa1e32b0_Out_2;
                    Unity_Multiply_float(_Divide_b7c139d64ea9401fbda3a903c9fd1bf6_Out_2, (_Property_92f37cd5909d40809e2b672d1636bd54_Out_0.xxx), _Multiply_6199970682ac4c9c947732b8aa1e32b0_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float2 _TilingAndOffset_2d869c568f8c4bd1935e9e1a5d383ff4_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, (_Property_f4af681ed89a4a3d8c81333e9f8b562d_Out_0.xx), (_Multiply_6199970682ac4c9c947732b8aa1e32b0_Out_2.xy), _TilingAndOffset_2d869c568f8c4bd1935e9e1a5d383ff4_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _GradientNoise_7d50ab18cca7435cbe45ace0410a84c7_Out_2;
                    Unity_GradientNoise_float(_TilingAndOffset_2d869c568f8c4bd1935e9e1a5d383ff4_Out_3, 10, _GradientNoise_7d50ab18cca7435cbe45ace0410a84c7_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Add_3ab7d42c644a4df381d663f07b7ab1e9_Out_2;
                    Unity_Add_float(_GradientNoise_5b5f40a249b347c9be3b4afc6d0ed3ad_Out_2, _GradientNoise_7d50ab18cca7435cbe45ace0410a84c7_Out_2, _Add_3ab7d42c644a4df381d663f07b7ab1e9_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Divide_cefb6bacdd4e476ea8103edefe43f584_Out_2;
                    Unity_Divide_float(_Add_3ab7d42c644a4df381d663f07b7ab1e9_Out_2, 2, _Divide_cefb6bacdd4e476ea8103edefe43f584_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Subtract_4da7b6862bcc45eca57cbd26b806eaf0_Out_2;
                    Unity_Subtract_float(_Divide_cefb6bacdd4e476ea8103edefe43f584_Out_2, 0.61, _Subtract_4da7b6862bcc45eca57cbd26b806eaf0_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_ce933f1cb0934b47a86069374aea82d8_Out_0 = _amplitude;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Multiply_fc80491e653843f7b95b7d963584d21d_Out_2;
                    Unity_Multiply_float(_Subtract_4da7b6862bcc45eca57cbd26b806eaf0_Out_2, _Property_ce933f1cb0934b47a86069374aea82d8_Out_0, _Multiply_fc80491e653843f7b95b7d963584d21d_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Combine_4394e5327dea4ebda9c6b40c020e0721_RGBA_4;
                    float3 _Combine_4394e5327dea4ebda9c6b40c020e0721_RGB_5;
                    float2 _Combine_4394e5327dea4ebda9c6b40c020e0721_RG_6;
                    Unity_Combine_float(_Split_ff0fd34a61f44fd7ae2f222441749bd9_R_1, _Multiply_fc80491e653843f7b95b7d963584d21d_Out_2, _Split_ff0fd34a61f44fd7ae2f222441749bd9_B_3, 0, _Combine_4394e5327dea4ebda9c6b40c020e0721_RGBA_4, _Combine_4394e5327dea4ebda9c6b40c020e0721_RGB_5, _Combine_4394e5327dea4ebda9c6b40c020e0721_RG_6);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float3 _Transform_5f6d055972de4e69871e05659dc0cf87_Out_1 = TransformWorldToObject(_Combine_4394e5327dea4ebda9c6b40c020e0721_RGB_5.xyz);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Combine_989bd6296fa44c898dce3b24fde18c9d_RGBA_4;
                    float3 _Combine_989bd6296fa44c898dce3b24fde18c9d_RGB_5;
                    float2 _Combine_989bd6296fa44c898dce3b24fde18c9d_RG_6;
                    Unity_Combine_float(_Split_ff0fd34a61f44fd7ae2f222441749bd9_R_1, _Split_ff0fd34a61f44fd7ae2f222441749bd9_G_2, _Split_ff0fd34a61f44fd7ae2f222441749bd9_B_3, 0, _Combine_989bd6296fa44c898dce3b24fde18c9d_RGBA_4, _Combine_989bd6296fa44c898dce3b24fde18c9d_RGB_5, _Combine_989bd6296fa44c898dce3b24fde18c9d_RG_6);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    #if defined(BOOLEAN_2D5E488208064DEDBE97E09FA59744E9_ON)
                    float3 _Waving_e9c7407f61464da88e74e85183ca2065_Out_0 = _Transform_5f6d055972de4e69871e05659dc0cf87_Out_1;
                    #else
                    float3 _Waving_e9c7407f61464da88e74e85183ca2065_Out_0 = _Combine_989bd6296fa44c898dce3b24fde18c9d_RGB_5;
                    #endif
                    #endif
                    description.Position = _Waving_e9c7407f61464da88e74e85183ca2065_Out_0;
                    description.Normal = IN.ObjectSpaceNormal;
                    description.Tangent = IN.ObjectSpaceTangent;
                    return description;
                }
    
                // Graph Pixel
                struct SurfaceDescription
                {
                    float3 BaseColor;
                    float Alpha;
                    float AlphaClipThreshold;
                };
                
                SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                {
                    SurfaceDescription surface = (SurfaceDescription)0;
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Property_cd262e3649c94d36ac1a6035934c82ba_Out_0 = _shallowWaterColor;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Property_c08d4525fbf641d78eb168f9e6c77374_Out_0 = _deepWaterColor;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _SceneDepth_ff2814420f634b6c9006b17db1b0db86_Out_1;
                    Unity_SceneDepth_Linear01_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_ff2814420f634b6c9006b17db1b0db86_Out_1);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Multiply_7fe029570de94c259af598c01f1e9fc7_Out_2;
                    Unity_Multiply_float(_SceneDepth_ff2814420f634b6c9006b17db1b0db86_Out_1, _ProjectionParams.z, _Multiply_7fe029570de94c259af598c01f1e9fc7_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_69b3cbbc42e345ba9fcd9de510b5e2d7_Out_0 = _depth;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0 = IN.ScreenPosition;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Split_4da6c10dd6e44537a1e2021901925b9e_R_1 = _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0[0];
                    float _Split_4da6c10dd6e44537a1e2021901925b9e_G_2 = _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0[1];
                    float _Split_4da6c10dd6e44537a1e2021901925b9e_B_3 = _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0[2];
                    float _Split_4da6c10dd6e44537a1e2021901925b9e_A_4 = _ScreenPosition_e04a41d97ebe4b608f969cae4a13abe1_Out_0[3];
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Add_5516261d5322477cbf6c851a3128394f_Out_2;
                    Unity_Add_float(_Property_69b3cbbc42e345ba9fcd9de510b5e2d7_Out_0, _Split_4da6c10dd6e44537a1e2021901925b9e_A_4, _Add_5516261d5322477cbf6c851a3128394f_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Subtract_f153dba44eeb4c808ffd45ea4a4f742e_Out_2;
                    Unity_Subtract_float(_Multiply_7fe029570de94c259af598c01f1e9fc7_Out_2, _Add_5516261d5322477cbf6c851a3128394f_Out_2, _Subtract_f153dba44eeb4c808ffd45ea4a4f742e_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Property_3b327dff25184e83be825e3db1854a26_Out_0 = _depthStrength;
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Multiply_bcf5cd29cecf4b4f97083346027d340a_Out_2;
                    Unity_Multiply_float(_Subtract_f153dba44eeb4c808ffd45ea4a4f742e_Out_2, _Property_3b327dff25184e83be825e3db1854a26_Out_0, _Multiply_bcf5cd29cecf4b4f97083346027d340a_Out_2);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Clamp_07516fbacac148a2ab07ae8f0615108e_Out_3;
                    Unity_Clamp_float(_Multiply_bcf5cd29cecf4b4f97083346027d340a_Out_2, 0, 1, _Clamp_07516fbacac148a2ab07ae8f0615108e_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float4 _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3;
                    Unity_Lerp_float4(_Property_cd262e3649c94d36ac1a6035934c82ba_Out_0, _Property_c08d4525fbf641d78eb168f9e6c77374_Out_0, (_Clamp_07516fbacac148a2ab07ae8f0615108e_Out_3.xxxx), _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3);
                    #endif
                    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                    float _Split_5dc8f38583ee40c19b6f09138a95e012_R_1 = _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3[0];
                    float _Split_5dc8f38583ee40c19b6f09138a95e012_G_2 = _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3[1];
                    float _Split_5dc8f38583ee40c19b6f09138a95e012_B_3 = _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3[2];
                    float _Split_5dc8f38583ee40c19b6f09138a95e012_A_4 = _Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3[3];
                    #endif
                    surface.BaseColor = (_Lerp_9c338f758d6f4f2c8d4c638e89b2f59d_Out_3.xyz);
                    surface.Alpha = _Split_5dc8f38583ee40c19b6f09138a95e012_A_4;
                    surface.AlphaClipThreshold = 0;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ObjectSpaceNormal =           input.normalOS;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ObjectSpaceTangent =          input.tangentOS;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ObjectSpacePosition =         input.positionOS;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpacePosition =          TransformObjectToWorld(input.positionOS);
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.uv0 =                         input.uv0;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.TimeParameters =              _TimeParameters.xyz;
                #endif
                
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                
                
                
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.WorldSpacePosition =          input.positionWS;
                #endif
                
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
                #endif
                
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
                #else
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                #endif
                #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                
                    return output;
                }
                
    
                // --------------------------------------------------
                // Main
    
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBR2DPass.hlsl"
    
                ENDHLSL
            }
        }
        CustomEditor "ShaderGraph.PBRMasterGUI"
        FallBack "Hidden/Shader Graph/FallbackError"
    }
